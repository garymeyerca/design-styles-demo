#!/usr/bin/env bash
# build-previews.sh — render homepage card previews from styles/*.html
#
# For each styles/<slug>.html, screenshots the rendered page via headless
# Chrome and writes a 700-wide webp to previews/<slug>.webp. Skips slugs
# that already have an up-to-date preview unless --force is passed.
#
# Usage:
#   bin/build-previews.sh              # only build missing / stale previews
#   bin/build-previews.sh --force      # rebuild every preview
#   bin/build-previews.sh wabi-sabi    # rebuild one (or more) by slug

set -euo pipefail

CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
STYLES_DIR="$ROOT/styles"
OUT_DIR="$ROOT/previews"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

# --- deps ---------------------------------------------------------------
[ -x "$CHROME" ] || { echo "error: Chrome not found at $CHROME" >&2; exit 1; }
command -v cwebp >/dev/null || {
  echo "error: cwebp not installed (brew install webp)" >&2; exit 1; }

# --- args ---------------------------------------------------------------
force=0
only=()
for arg in "$@"; do
  case "$arg" in
    --force|-f) force=1 ;;
    -h|--help)
      sed -n '2,11p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) only+=("$arg") ;;
  esac
done

mkdir -p "$OUT_DIR"

# --- pick targets -------------------------------------------------------
shopt -s nullglob
if [ "${#only[@]}" -gt 0 ]; then
  targets=()
  for slug in "${only[@]}"; do
    src="$STYLES_DIR/$slug.html"
    [ -f "$src" ] || { echo "skip: no styles/$slug.html" >&2; continue; }
    targets+=("$src")
  done
else
  targets=("$STYLES_DIR"/*.html)
fi

[ "${#targets[@]}" -gt 0 ] || { echo "nothing to build."; exit 0; }

# --- render -------------------------------------------------------------
built=0; skipped=0; total=${#targets[@]}; i=0
for src in "${targets[@]}"; do
  i=$((i+1))
  slug="$(basename "$src" .html)"
  out="$OUT_DIR/$slug.webp"

  if [ "$force" -eq 0 ] && [ -f "$out" ] && [ "$out" -nt "$src" ]; then
    skipped=$((skipped+1))
    printf '\r[%2d/%2d] skip %s              ' "$i" "$total" "$slug"
    continue
  fi

  printf '\r[%2d/%2d] %s              ' "$i" "$total" "$slug"
  "$CHROME" --headless=new --disable-gpu --hide-scrollbars --no-first-run \
    --no-default-browser-check --virtual-time-budget=2000 \
    --window-size=1400,900 \
    --screenshot="$TMP_DIR/$slug.png" \
    "file://$src" >/dev/null 2>&1

  cwebp -quiet -q 75 -resize 700 0 "$TMP_DIR/$slug.png" -o "$out"
  built=$((built+1))
done

printf '\rdone — %d built, %d already up to date.        \n' "$built" "$skipped"
