#!/usr/bin/env python3
"""
Fix package name in smali_nores from com.anthropic.claude to com.anthropic.hermes
"""
import os
import re
import subprocess

SMALI_DIR = r"C:\Users\JISHNU PG\Music\Claude\smali_nores"
OLD_PKG = "com/anthropic/claude"
NEW_PKG = "com/anthropic/hermes"
OLD_PKG_DOT = "com.anthropic.claude"
NEW_PKG_DOT = "com.anthropic.hermes"

def fix_file(filepath):
    with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
        content = f.read()
    
    # Replace package references
    new_content = content.replace(OLD_PKG, NEW_PKG)
    new_content = new_content.replace(OLD_PKG_DOT, NEW_PKG_DOT)
    
    if new_content != content:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(new_content)
        return True
    return False

def main():
    print(f"Scanning {SMALI_DIR} for package references...")
    fixed_count = 0
    for root, dirs, files in os.walk(SMALI_DIR):
        for file in files:
            if file.endswith('.smali'):
                filepath = os.path.join(root, file)
                if fix_file(filepath):
                    fixed_count += 1
                    print(f"  Fixed: {filepath}")
    
    print(f"\nFixed {fixed_count} files")
    
    # Also fix the directory structure
    old_pkg_dir = os.path.join(SMALI_DIR, *OLD_PKG.split('/'))
    new_pkg_dir = os.path.join(SMALI_DIR, *NEW_PKG.split('/'))
    
    if os.path.exists(old_pkg_dir):
        # Create new directory structure
        os.makedirs(os.path.dirname(new_pkg_dir), exist_ok=True)
        # Move the directory
        import shutil
        shutil.move(old_pkg_dir, new_pkg_dir)
        print(f"Moved package directory: {old_pkg_dir} -> {new_pkg_dir}")

if __name__ == "__main__":
    main()