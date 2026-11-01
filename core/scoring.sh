#!/usr/bin/env bash
# Risk Assessment Engine and Scoring Calculator

# Global score tracker
SECURITY_SCORE=100
TOTAL_FINDINGS=0

calculate_deduction() {
    local severity="$1"
    case "$severity" in
        "CRITICAL") echo 15 ;;
        "HIGH") echo 10 ;;
        "MEDIUM") echo 5 ;;
        "LOW") echo 2 ;;
        "INFO") echo 0 ;;
        *) echo 0 ;;
    esac
}

apply_finding() {
    local severity="$1"
    local deduction=$(calculate_deduction "$severity")
    SECURITY_SCORE=$((SECURITY_SCORE - deduction))
    [ $SECURITY_SCORE -lt 0 ] && SECURITY_SCORE=0
    TOTAL_FINDINGS=$((TOTAL_FINDINGS + 1))
}
