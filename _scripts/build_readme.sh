#!/bin/bash

# 1. Define paths (Adjust these to your setup)
VAULT_PATH="."
DASHBOARD_NOTE="Dashboard.md"
TEMP_EXPORT_DIR="temp_export"

# 2. Export the vault to a temporary standard Markdown format
# --hard-linebreaks ensures the task lists look right on GitHub
obsidian-export --hard-linebreaks "$VAULT_PATH" "$TEMP_EXPORT_DIR"

# 3. Move the rendered dashboard to the root README.md
cp "$TEMP_EXPORT_DIR/$DASHBOARD_NOTE" "README.md"

# 4. Cleanup
rm -rf "$TEMP_EXPORT_DIR"

echo "✅ README.md updated from $DASHBOARD_NOTE"
