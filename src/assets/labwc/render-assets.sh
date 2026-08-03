#! /usr/bin/env bash

INKSCAPE="/usr/bin/inkscape"
OPTIPNG="/usr/bin/optipng"

INDEX="assets.txt"

for i in `cat $INDEX`; do
  for color in '-Dark' '-Light'; do
    for theme in '' '-nord'; do
        ASSETS_DIR="assets${color}${theme}"
        SRC_FILE="assets${color}${theme}.svg"

        mkdir -p $ASSETS_DIR

          echo
          echo Rendering $ASSETS_DIR/$i.svg
          $INKSCAPE --export-id=$i \
                    --export-id-only \
                    --export-filename=$ASSETS_DIR/$i.svg $SRC_FILE >/dev/null

    done
  done
done

exit 0
