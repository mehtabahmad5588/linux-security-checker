#!/usr/bin/env bash
# Detection module for OS, kernel, architecture, and tools

detect_system() {
    OS_NAME="Unknown"
    OS_VERSION="Unknown"
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS_NAME="${ID:-unknown}"
        OS_VERSION="${VERSION_ID:-unknown}"
    elif [ -f /etc/debian_version ]; then
        OS_NAME="debian"
        OS_VERSION=$(cat /etc/debian_version)
    elif [ -f /etc/redhat-release ]; then
        OS_NAME="rhel"
        OS_VERSION=$(cat /etc/redhat-release)
    fi

    KERNEL_VERSION=$(uname -r)
    ARCH=$(uname -m)
    HOSTNAME_VAL=$(hostname)
    UPTIME_VAL=$(uptime -p 2>/dev/null || uptime)
    CURRENT_USER=$(whoami)
    IS_ROOT=0
    [ "$EUID" -eq 0 ] && IS_ROOT=1

    # Package manager detection
    PKG_MANAGER="unknown"
    if command -v apt-get &>/dev/null; then
        PKG_MANAGER="apt"
    elif command -v dnf &>/dev/null; then
        PKG_MANAGER="dnf"
    elif command -v yum &>/dev/null; then
        PKG_MANAGER="yum"
    elif command -v pacman &>/dev/null; then
        PKG_MANAGER="pacman"
    fi
}
