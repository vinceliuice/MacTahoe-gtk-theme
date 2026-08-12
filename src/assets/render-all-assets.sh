#!/usr/bin/env bash

set -euo pipefail

RENDER_SVG="$(command -v rendersvg)" || true
INKSCAPE="$(command -v inkscape)" || true
OPTIPNG="$(command -v optipng)" || true

if [[ -z "${INKSCAPE}" ]] && [[ -z "${RENDER_SVG}" ]]; then
  echo "inkscape or rendersvg needs to be installed to generate the assets."
  exit 1
fi

cd "$(dirname "${BASH_SOURCE[0]}")"

echo "Rendering gtk-2.0 assets"
(cd gtk-2.0 && ./render-assets.sh)

echo "Rendering gtk-3.0 assets"
(cd gtk-3.0 && ./render-thumbnails.sh)
(cd gtk-3.0/common-assets && ./render-assets.sh)
(cd gtk-3.0/windows-assets && ./render-assets.sh && ./render-alt-assets.sh)

echo "Rendering cinnamon thumbnails"
(cd cinnamon && ./render-thumbnails.sh)

echo "Rendering metacity-1 assets"
(cd metacity-1 && ./render-assets.sh)

echo "Rendering xfwm4 assets"
(cd xfwm4 && ./render-assets.sh)

exit 0
