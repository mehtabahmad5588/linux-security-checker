#!/usr/bin/env bash
# ==============================================================================
# Linsec-Guard: Linux Security Checker & Hardening Automation Tool
# ==============================================================================

set -uo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source Core Libraries
source "$BASE_DIR/core/logging.sh"
source "$BASE_DIR/core/detection.sh"
source "$BASE_DIR/core/scoring.sh"
source "$BASE_DIR/core/reporting.sh"
source "$BASE_DIR/core/remediation.sh"

# Source Modules
source "$BASE_DIR/modules/system.sh"
source "$BASE_DIR/modules/ssh.sh"

print_help() {
    echo "Linsec-Guard - Linux Security Checker & Hardening Automation Tool"
    echo "Usage: ./linux-checker.sh [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --quick             Run quick security assessment"
    echo "  --full              Run full security audit across all modules"
    echo "  --module <name>     Run specific module (system, ssh, etc.)"
    echo "  --report <format>   Generate report format (terminal, json, html)"
    echo "  --remediate         Apply automated hardening remediations"
    echo "  --dry-run           Simulate remediation actions safely"
    echo "  --help              Display this help message"
    echo "  --version           Display version information"
}

main() {
    detect_system

    local REPORT_FORMAT="terminal"
    local MODE="full"
    local TARGET_MODULE=""

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --quick)
                MODE="quick"
                shift
                ;;
            --full)
                MODE="full"
                shift
                ;;
            --module)
                MODE="module"
                TARGET_MODULE="$2"
                shift 2
                ;;
            --report)
                REPORT_FORMAT="$2"
                shift 2
                ;;
            --help)
                print_help
                exit 0
                ;;
            --version)
                echo "linsec-guard v1.0.0"
                exit 0
                ;;
            *)
                log_error "Unknown option: $1"
                print_help
                exit 1
                ;;
        esac
    done

    log_info "Starting linsec-guard audit on $HOSTNAME_VAL ($OS_NAME $OS_VERSION)..."

    if [ "$MODE" = "full" ] || [ "$MODE" = "quick" ]; then
        audit_system
        audit_ssh
    elif [ "$MODE" = "module" ]; then
        case "$Target_MODULE" in
            system) audit_system ;;
            ssh) audit_ssh ;;
            *) log_error "Unknown module: $TARGET_MODULE"; exit 1 ;;
        esac
    fi

    # Generate Reports
    mkdir -p "$BASE_DIR/reports"
    case "$REPORT_FORMAT" in
        json)
            generate_json_report "$BASE_DIR/reports/security_report.json"
            log_info "JSON report generated at reports/security_report.json"
            ;;
        html)
            generate_html_report "$BASE_DIR/reports/security_report.html"
            log_info "HTML report generated at reports/security_report.html"
            ;;
        terminal|*)
            generate_terminal_report
            ;;
    esac
}

main "$@"
