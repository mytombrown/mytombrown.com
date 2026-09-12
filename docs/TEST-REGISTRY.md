# Test registry — mytombrown.com

| id | tier | for | proves | runs |
|---|---|---|---|---|
| WEB-T-1 | T0 | WEB-733 (Tom, 2026-09-12: "build a site for how-to and overall product awareness on mytombrown.com") | **The site is live and teaches the game.** `https://mytombrown.com/` answers 200 and `/squishy-math/` carries "How to play". `--local` proves the same text is in the files on disk and runs in the Pages workflow before every deploy, so a page cannot lose its how-to and still ship. Red until the apex DNS records exist (Tom's hands) | `bash scripts/check-site.sh` (live) · `bash scripts/check-site.sh --local` (workflow) |
