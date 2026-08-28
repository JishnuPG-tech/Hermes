import re

with open(r"C:\Users\JISHNU PG\Music\Claude\smali_full\AndroidManifest.xml", 'r', encoding='utf-8') as f:
    content = f.read()

# 1. Change package name
content = content.replace('package="com.anthropic.claude"', 'package="com.anthropic.hermes"')

# 2. Change application class
content = content.replace('android:name="com.anthropic.claude.application.ClaudeApplication"',
                         'android:name="com.anthropic.hermes.application.ClaudeApplication"')

# 3. Change all activity/service/receiver/provider class names
content = re.sub(r'android:name="com\.anthropic\.claude\.([^"]+)"',
                 r'android:name="com.anthropic.hermes.\1"', content)

# 4. Change authorities
content = re.sub(r'android:authorities="com\.anthropic\.claude\.([^"]+)"',
                 r'android:authorities="com.anthropic.hermes.\1"', content)

# 5. Change permissions
content = re.sub(r'android:name="com\.anthropic\.claude\.([^"]+)" android:protectionLevel',
                 r'android:name="com.anthropic.hermes.\1" android:protectionLevel', content)
content = re.sub(r'android:permission="com\.anthropic\.claude\.([^"]+)"',
                 r'android:permission="com.anthropic.hermes.\1"', content)

# 6. Change intent actions
content = re.sub(r'android:name="com\.anthropic\.claude\.action\.([^"]+)"',
                 r'android:name="com.anthropic.hermes.action.\1"', content)

# 7. Change pathPrefix from /claude to /hermes
content = content.replace('android:pathPrefix="/claude"', 'android:pathPrefix="/hermes"')

# 8. Change query package names
content = re.sub(r'<package android:name="com\.anthropic\.claude\.([^"]+)"',
                 r'<package android:name="com.anthropic.hermes.\1"', content)

# 9. Change the custom scheme
content = content.replace('android:scheme="claude"', 'android:scheme="hermes"')

# 10. Change any remaining com.anthropic.claude references in meta-data etc
content = content.replace('com.anthropic.claude.', 'com.anthropic.hermes.')

with open(r"C:\Users\JISHNU PG\Music\Claude\smali_full\AndroidManifest.xml", 'w', encoding='utf-8') as f:
    f.write(content)

print("Manifest fixed!")