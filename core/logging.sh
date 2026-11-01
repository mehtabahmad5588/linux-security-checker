#!/usr/bin/env bash
# Centralized Logging functions

log_info() {
    echo -e "[\033[32mINFO\033[0m] $1"
}

log_warn() {
    echo -e "[\033[33mWARN\033[0m] $1"
}

log_error() {
    echo -e "[\033[31mERROR\033[0m] $1"
}
