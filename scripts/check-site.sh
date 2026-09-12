#!/usr/bin/env zsh
# WEB-T-1 — mytombrown.com is live and the Squishy Math page teaches the game.
#
#   zsh scripts/check-site.sh            # live: https://mytombrown.com/ answers 200,
#                                        #       /squishy-math/ carries 'How to play'
#   zsh scripts/check-site.sh --local    # the files on disk carry the same text
#                                        #       (runs in the Pages workflow before deploy)
set -uo pipefail
root="${0:A:h:h}"
fails=0
red() { print -u2 -- "FAIL: $*"; fails=$((fails + 1)); }
if [[ "${1:-}" == "--local" ]]; then
  for p in index.html squishy-math/index.html squishy-words/index.html team-assist/index.html srt-stream-tester/index.html family-meal-planner/index.html; do
    [[ -s "$root/$p" ]] || red "missing $p"
  done
  grep -q 'How to play' "$root/squishy-math/index.html" || red "squishy-math/index.html has no 'How to play'"
  grep -q 'How to play' "$root/squishy-words/index.html" || red "squishy-words/index.html has no 'How to play'"
  [[ "$(cat "$root/CNAME")" == "mytombrown.com" ]] || red "CNAME is not mytombrown.com"
else
  code=$(curl -s -o /dev/null -w '%{http_code}' --max-time 20 https://mytombrown.com/ || print 000)
  [[ "$code" == "200" ]] || red "https://mytombrown.com/ answered $code (DNS or Pages not live yet)"
  if curl -s --max-time 20 https://mytombrown.com/squishy-math/ | grep -q 'How to play'; then
    print "ok: /squishy-math/ carries 'How to play'"
  else
    red "https://mytombrown.com/squishy-math/ has no 'How to play'"
  fi
fi
if (( fails == 0 )); then print "PASS WEB-T-1 ($(date -u +%Y-%m-%dT%H:%M:%SZ))"; exit 0; fi
exit 1
