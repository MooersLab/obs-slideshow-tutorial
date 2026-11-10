#!/usr/bin/env bash
# pdf2png.sh
# Convert every page of a PDF slide deck into numbered PNG files
# for the OBS "Image Slide Show" source.
#
# Usage:
#   ./pdf2png.sh talk.pdf            # writes talk_png/slide-01.png ...
#   ./pdf2png.sh talk.pdf outdir     # writes outdir/slide-01.png ...
#   WIDTH=1280 ./pdf2png.sh talk.pdf # override output width (default 1920)
#
# Requires pdftoppm (Poppler).
#   macOS:  brew install poppler
#   Debian: sudo apt install poppler-utils
# Falls back to ImageMagick (magick or convert) plus Ghostscript if
# pdftoppm is missing.

set -euo pipefail

if [[ $# -lt 1 ]]; then
    echo "Usage: $0 input.pdf [output_dir]" >&2
    exit 1
fi

pdf="$1"
if [[ ! -f "$pdf" ]]; then
    echo "Error: '$pdf' not found." >&2
    exit 1
fi

base="$(basename "${pdf%.*}")"
outdir="${2:-${base}_png}"
width="${WIDTH:-1920}"   # 1920 wide downsamples cleanly to 1280x720 in OBS

mkdir -p "$outdir"

if command -v pdftoppm >/dev/null 2>&1; then
    # -scale-to-x sets the width; -scale-to-y -1 keeps the aspect ratio.
    # pdftoppm zero-pads page numbers (01, 02, ...) so files sort correctly.
    pdftoppm -png -scale-to-x "$width" -scale-to-y -1 "$pdf" "$outdir/slide"
elif command -v magick >/dev/null 2>&1 || command -v convert >/dev/null 2>&1; then
    im="$(command -v magick || command -v convert)"
    # Render at high density, then resize. %03d gives 000, 001, ...
    "$im" -density 300 "$pdf" -background white -alpha remove \
          -resize "${width}x" "$outdir/slide-%03d.png"
else
    echo "Error: install poppler (pdftoppm) or ImageMagick." >&2
    exit 1
fi

count=$(find "$outdir" -maxdepth 1 -name 'slide-*.png' | wc -l | tr -d ' ')
echo "Wrote $count PNG files to $outdir/"

# Warn if the slides are not 16:9, because they will be letterboxed at 720p.
first="$(find "$outdir" -maxdepth 1 -name 'slide-*.png' | sort | head -n 1)"
if command -v sips >/dev/null 2>&1; then
    sips -g pixelWidth -g pixelHeight "$first" | tail -n 2
elif command -v identify >/dev/null 2>&1; then
    identify -format 'Size of first slide: %wx%h\n' "$first"
fi
