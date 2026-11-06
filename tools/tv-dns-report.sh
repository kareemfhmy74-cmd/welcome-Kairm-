#!/usr/bin/env bash
# Lists the domains one device (your TV) asked your DNS server to resolve, most frequent first.
# Works on a Pi-hole / dnsmasq query log ("query[A] <domain> from <ip>" lines).
# Usage: tools/tv-dns-report.sh <tv-ip> [logfile]    (default log: /var/log/pihole/pihole.log)
set -euo pipefail
ip="${1:?usage: $0 <tv-ip> [logfile]}"
log="${2:-/var/log/pihole/pihole.log}"
[ -r "$log" ] || { echo "cannot read $log" >&2; exit 1; }
awk -v ip="$ip" '
  / query\[[A-Za-z0-9]+\] / && $NF == ip && $(NF-1) == "from" {
    for (i = 1; i <= NF; i++) if ($i ~ /^query\[/) { print tolower($(i+1)); break }
  }' "$log" | sort | uniq -c | sort -rn
