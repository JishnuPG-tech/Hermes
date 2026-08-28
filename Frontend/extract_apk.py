import zipfile
import os

apk_path = r"C:\Users\JISHNU PG\Music\Claude\Claude.apk"
extract_dir = r"C:\Users\JISHNU PG\Music\Claude\apk_extracted"

os.makedirs(extract_dir, exist_ok=True)

with zipfile.ZipFile(apk_path, 'r') as zf:
    for member in zf.infolist():
        # Skip the problematic file with colon in name
        if ':' in member.filename:
            print(f"Skipping: {member.filename}")
            continue
        try:
            zf.extract(member, extract_dir)
            print(f"Extracted: {member.filename}")
        except Exception as e:
            print(f"Error extracting {member.filename}: {e}")

print("Done!")