---
domain: General
type: Concept
created: 2025-12-23
location:
tags:
  - library
---

# Git PreCommit Hook

## Content

Added a precommit hook to `.git/hooks/precommit`:
```bash
#!/bin/bash

# Run the export script
./scripts/build-readme.sh

# Add the newly generated README to the current commit
git add README.md
```

This requires `cargo`:
```bash
brew install cargo
```

Then:
```bash
cargo install obsidian-expor
```