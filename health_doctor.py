#!/usr/bin/env python3
"""
Hermes Persistence & Database Health Doctor
============================================
Monitors SQLite databases, verifies disk health, creates safe local backups,
and triggers periodic cloud vault synchronizations without causing WAL lock contention.
"""

import os
import time
import shutil
import sqlite3
import logging
from pathlib import Path

logging.basicConfig(level=logging.INFO, format="%(asctime)s [%(levelname)s] [HealthDoctor] %(message)s")
logger = logging.getLogger("HealthDoctor")

DATA_DIR = Path("/data")
HERMES_DIR = DATA_DIR / "hermes"
BACKUP_DIR = DATA_DIR / "backups"

HERMES_DIR.mkdir(parents=True, exist_ok=True)
BACKUP_DIR.mkdir(parents=True, exist_ok=True)

def verify_and_backup_db(db_rel: str):
    db_file = HERMES_DIR / db_rel
    if not db_file.exists() or db_file.stat().st_size == 0:
        return

    # Non-blocking read-only check
    try:
        conn = sqlite3.connect(f"file:{db_file}?mode=ro", uri=True, timeout=5.0)
        cur = conn.cursor()
        cur.execute("PRAGMA quick_check;")
        res = cur.fetchone()
        conn.close()

        if res and res[0] == "ok":
            backup_dest = BACKUP_DIR / f"{Path(db_rel).stem}_latest.sqlite"
            # Non-blocking online backup API
            src_conn = sqlite3.connect(f"file:{db_file}?mode=ro", uri=True, timeout=5.0)
            dst_conn = sqlite3.connect(str(backup_dest))
            src_conn.backup(dst_conn)
            dst_conn.close()
            src_conn.close()
        else:
            logger.warning(f"Integrity check returned non-ok for {db_rel}: {res}")
    except Exception as e:
        logger.warning(f"DB check/backup notice for {db_rel}: {e}")

def trigger_cloud_vault_sync():
    try:
        from vault_sync import backup_to_vault
        logger.info("Executing periodic cloud vault backup...")
        ok, msg = backup_to_vault()
        logger.info(f"Cloud vault backup result: {msg}")
    except Exception as e:
        logger.error(f"Cloud vault periodic sync error: {e}")

def main():
    logger.info("Hermes Health Doctor daemon active (local check: 60s, cloud sync: 900s).")
    last_cloud_sync = time.time()
    
    # Wait initial 60 seconds after boot before first checks
    time.sleep(60)

    while True:
        try:
            verify_and_backup_db("memory.sqlite")
            verify_and_backup_db("state.db")

            now = time.time()
            if now - last_cloud_sync >= 900:  # Every 15 minutes
                trigger_cloud_vault_sync()
                last_cloud_sync = now
        except Exception as e:
            logger.error(f"Unexpected health doctor cycle error: {e}")

        time.sleep(60)

if __name__ == "__main__":
    main()
