#!/usr/bin/env bash
audit_system() {
    log_info "Running System Information Audit..."
    echo "OS: $OS_NAME $OS_VERSION"
    echo "Kernel: $KERNEL_VERSION"
    echo "Architecture: $ARCH"
    echo "Uptime: $UPTIME_VAL"
}
