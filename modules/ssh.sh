#!/usr/bin/env bash
audit_ssh() {
    log_info "Running SSH Security Audit..."
    if [ -f /etc/ssh/sshd_config ]; then
        if grep -qi "^[[:space:]]*PermitRootLogin[[:space:]]*yes" /etc/ssh/sshd_config; then
            log_warn "PermitRootLogin is enabled in SSH."
            apply_finding "HIGH"
        else
            log_info "PermitRootLogin is securely configured."
        fi
    else
        log_warn "sshd_config not found or inaccessible."
    fi
}
