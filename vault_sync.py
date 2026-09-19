#!/usr/bin/env python3
"""
Hermes Cloud Vault Synchronizer
================================
Provides zero-loss persistence for Hermes Agent across container restarts,
rebuilds, and ephemeral-disk resets by maintaining a bidirectional sync
between /data and a private Hugging Face Dataset repository (Jishnupg/hermes-storage-vault).
"""

import os
import sys
import tarfile
import shutil
import sqlite3
import logging
import tempfile
from datetime import datetime
from pathlib import Path

logging.basicConfig(level=logging.INFO, format="%(asctime)s [%(levelname)s] [HermesVaultSync] %(message)s")
logger = logging.getLogger("HermesVaultSync")

VAULT_REPO = os.environ.get("HERMES_VAULT_REPO", "Jishnupg/hermes-storage-vault")
DATA_DIR = Path(os.environ.get("DATA_DIR", "/data"))
SNAPSHOT_NAME = "hermes_vault_snapshot.tar.gz"

def get_hf_token():
    return (
        os.environ.get("HF_TOKEN")
        or os.environ.get("HUGGINGFACE_API_KEY")
        or ""
    )

def restore_from_vault() -> tuple[bool, str]:
    """Restores /data state from private HF Dataset if local databases are missing."""
    token = get_hf_token()
    if not token:
        msg = "No HF_TOKEN available; cloud vault restore skipped."
        logger.info(msg)
        return False, msg

    DATA_DIR.mkdir(parents=True, exist_ok=True)
    memory_db = DATA_DIR / "hermes" / "memory.sqlite"
    conv_file = DATA_DIR / "conversations" / "history.json"

    # If authoritative local state already exists and has data, keep it
    if memory_db.exists() and memory_db.stat().st_size > 0:
        msg = f"Authoritative local memory found at {memory_db} ({memory_db.stat().st_size} bytes)."
        logger.info(msg)
        return True, msg

    try:
        from huggingface_hub import hf_hub_download
        logger.info(f"Checking for snapshot in cloud vault {VAULT_REPO}...")
        downloaded = hf_hub_download(
            repo_id=VAULT_REPO,
            filename=SNAPSHOT_NAME,
            repo_type="dataset",
            token=token,
        )
        if downloaded and os.path.exists(downloaded):
            logger.info(f"Extracting vault snapshot from {downloaded} into {DATA_DIR}...")
            with tarfile.open(downloaded, "r:gz") as tar:
                tar.extractall(path=DATA_DIR)
            msg = f"Successfully restored vault snapshot into {DATA_DIR}."
            logger.info(msg)
            return True, msg
    except Exception as exc:
        msg = f"Vault restore note: {exc}"
        logger.info(msg)
        return False, msg

    return False, "No vault snapshot found"

def backup_to_vault() -> tuple[bool, str]:
    """Creates a snapshot of /data and pushes it to private HF Dataset."""
    token = get_hf_token()
    if not token:
        msg = "HF_TOKEN not set; cloud vault backup skipped."
        logger.warning(msg)
        return False, msg

    DATA_DIR.mkdir(parents=True, exist_ok=True)

    with tempfile.TemporaryDirectory() as tmpdir:
        staging_dir = Path(tmpdir) / "staging"
        staging_dir.mkdir(parents=True, exist_ok=True)

        # 1. Safely copy SQLite databases in read-only mode without WAL lock collisions
        for db_rel in ["hermes/memory.sqlite", "hermes/state.db"]:
            src_db = DATA_DIR / db_rel
            if src_db.exists() and src_db.stat().st_size > 0:
                dest_db = staging_dir / db_rel
                dest_db.parent.mkdir(parents=True, exist_ok=True)
                try:
                    src_conn = sqlite3.connect(f"file:{src_db}?mode=ro", uri=True, timeout=5.0)
                    dst_conn = sqlite3.connect(str(dest_db))
                    src_conn.backup(dst_conn)
                    dst_conn.close()
                    src_conn.close()
                    logger.info(f"Safely backed up SQLite database: {db_rel}")
                except Exception as e:
                    logger.warning(f"Could not use SQLite backup API for {src_db}, falling back to copy: {e}")
                    shutil.copy2(src_db, dest_db)

        # 2. Copy conversation history, obsidian notes, skills, webui data
        for folder_rel in ["conversations", "obsidian/vault", "hermes/skills", "hermes/webui", "sessions"]:
            src_folder = DATA_DIR / folder_rel
            if src_folder.exists():
                dest_folder = staging_dir / folder_rel
                dest_folder.parent.mkdir(parents=True, exist_ok=True)
                if src_folder.is_dir():
                    shutil.copytree(src_folder, dest_folder, dirs_exist_ok=True)
                else:
                    shutil.copy2(src_folder, dest_folder)

        # 3. Create compressed tarball
        archive_path = Path(tmpdir) / SNAPSHOT_NAME
        with tarfile.open(archive_path, "w:gz") as tar:
            for item in staging_dir.iterdir():
                tar.add(item, arcname=item.name)

        archive_size = archive_path.stat().st_size
        logger.info(f"Snapshot archive created ({archive_size} bytes). Uploading to {VAULT_REPO}...")

        try:
            from huggingface_hub import HfApi
            api = HfApi(token=token)
            api.upload_file(
                path_or_fileobj=str(archive_path),
                path_in_repo=SNAPSHOT_NAME,
                repo_id=VAULT_REPO,
                repo_type="dataset",
                commit_message=f"Auto-vault snapshot {datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S UTC')}",
            )
            msg = f"Successfully uploaded snapshot ({archive_size} bytes) to {VAULT_REPO}."
            logger.info(msg)
            return True, msg
        except Exception as exc:
            msg = f"Failed to upload snapshot to cloud vault: {exc}"
            logger.error(msg)
            return False, msg

if __name__ == "__main__":
    action = sys.argv[1] if len(sys.argv) > 1 else "backup"
    if action == "restore":
        ok, msg = restore_from_vault()
    else:
        ok, msg = backup_to_vault()
    print(msg)
