#!/usr/bin/env bash
# Safe Remediation & Rollback Engine

backup_file() {
    local file="$1"
    if [ -f "$file" ]; then
        local backup_path="./backups/$(basename "$file").$(date +%Y%m%d%H%M%S).bak"
        cp "$file" "$backup_path"
        echo "[+] Backup created: $backup_path"
    fi
}
