#!/usr/bin/env bash
# Reporting System: Terminal, JSON, and HTML

generate_terminal_report() {
    echo "=================================================="
    echo "         LINSEC-GUARD SECURITY REPORT             "
    echo "=================================================="
    echo "OS: $OS_NAME $OS_VERSION | Kernel: $KERNEL_VERSION"
    echo "Hostname: $HOSTNAME_VAL | User: $CURRENT_USER"
    echo "Security Score: $SECURITY_SCORE / 100"
    echo "Total Findings: $TOTAL_FINDINGS"
    echo "=================================================="
}

generate_json_report() {
    local report_file="$1"
    cat << EOF > "$report_file"
{
  "timestamp": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "system": {
    "os": "$OS_NAME",
    "version": "$OS_VERSION",
    "kernel": "$KERNEL_VERSION",
    "architecture": "$ARCH",
    "hostname": "$HOSTNAME_VAL"
  },
  "score": $SECURITY_SCORE,
  "findings_count": $TOTAL_FINDINGS
}
EOF
}

generate_html_report() {
    local report_file="$1"
    cat << EOF > "$report_file"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Linsec-Guard Security Report</title>
    <style>
        body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; background: #0f172a; color: #f8fafc; margin: 0; padding: 40px; }
        .container { max-width: 900px; margin: auto; background: #1e293b; padding: 30px; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.3); }
        h1 { color: #38bdf8; border-bottom: 2px solid #334155; padding-bottom: 10px; }
        .score-box { font-size: 2.5rem; font-weight: bold; color: #4ade80; margin: 20px 0; }
        .card { background: #334155; padding: 15px; border-radius: 8px; margin-bottom: 15px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Linsec-Guard Security Assessment</h1>
        <div class="card">
            <h3>System Information</h3>
            <p><strong>OS:</strong> $OS_NAME $OS_VERSION</p>
            <p><strong>Kernel:</strong> $KERNEL_VERSION</p>
            <p><strong>Hostname:</strong> $HOSTNAME_VAL</p>
        </div>
        <div class="score-box">Security Score: $SECURITY_SCORE / 100</div>
    </div>
</body>
</html>
EOF
}
