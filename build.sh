#!/bin/bash

set -e

echo "=================================="
echo "      EasyMaps Build v1.1.0"
echo "=================================="
echo

BASE="$(cd "$(dirname "$0")" && pwd)"
GARMIN_DIR="$(cd "$BASE/.." && pwd)"

MKGMAP_DIR="$GARMIN_DIR/mkgmap"
SPLITTER_DIR="$GARMIN_DIR/splitter-r654"

STYLE_ROOT="$BASE"
TYP_ROOT="$BASE"

BUILD_DIR="$GARMIN_DIR/build"
SPLIT_DIR="$BUILD_DIR/split"

OUTPUT_DIR="$BUILD_DIR/output"

# Dependency checks
if ! command -v java >/dev/null 2>&1; then
    echo
    echo "Error: Java is not installed or not found in PATH."
    exit 1
fi

if [ ! -f "$SPLITTER_DIR/splitter.jar" ]; then
    echo
    echo "Error: splitter.jar not found:"
    echo "  $SPLITTER_DIR/splitter.jar"
    exit 1
fi

if [ ! -f "$MKGMAP_DIR/mkgmap-r4924/mkgmap.jar" ]; then
    echo
    echo "Error: mkgmap.jar not found:"
    echo "  $MKGMAP_DIR/mkgmap-r4924/mkgmap.jar"
    exit 1
fi

PBF_FILE="$1"

MAP_BASENAME="$(basename "$PBF_FILE" .osm.pbf)"
DISPLAY_NAME="$MAP_BASENAME"
DISPLAY_NAME="${DISPLAY_NAME%-[0-9]*}"
DISPLAY_NAME="${DISPLAY_NAME//-/ }"
DISPLAY_NAME="$(echo "$DISPLAY_NAME" | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)}1')"
OUTPUT_IMG="EasyMaps-${MAP_BASENAME}.img"

if [ -z "$PBF_FILE" ]; then
    echo "Usage:"
    echo "  ./build.sh <map.osm.pbf>"
    exit 1
fi

if [ ! -f "$PBF_FILE" ]; then
    echo
    echo "Error: PBF file not found:"
    echo "  $PBF_FILE"
    exit 1
fi

mkdir -p "$SPLIT_DIR"
mkdir -p "$OUTPUT_DIR"

echo "Input : $(basename \"$PBF_FILE\")"
echo "Output: $OUTPUT_IMG"
echo

echo "[1/3] Splitting map..."

rm -rf "$SPLIT_DIR"
mkdir -p "$SPLIT_DIR"

cd "$SPLIT_DIR"

java -Xmx4G -jar "$SPLITTER_DIR/splitter.jar" \
  --mapid=63240001 \
  --output=pbf \
  "$PBF_FILE"

if [ ! -f "template.args" ]; then
    echo
    echo "Error: splitter did not create template.args"
    exit 1
fi

echo "✔ Map split"
echo

echo "[2/3] Compiling TYP..."

java -cp "$MKGMAP_DIR/mkgmap-r4924/mkgmap.jar" \
  uk.me.parabola.mkgmap.main.TypCompiler \
  "$TYP_ROOT/typ/EasyMaps.txt" \
  "$TYP_ROOT/typ/EasyMaps.typ"

echo "✔ TYP compiled"
echo

echo "[3/3] Building Garmin map..."

cd "$SPLIT_DIR"

java -Xmx4G -jar "$MKGMAP_DIR/mkgmap-r4924/mkgmap.jar" \
  --style-file="$STYLE_ROOT/style" \
  --style=EasyMaps \
  --family-id=10010 \
  --product-id=1 \
  --family-name="EasyMaps" \
  --series-name="EasyMaps / $DISPLAY_NAME" \
  --description="EasyMaps / $DISPLAY_NAME" \
  --overview-mapname=EASYMAP \
  --route \
  --gmapsupp \
  -c template.args \
  "$TYP_ROOT/typ/EasyMaps.typ"

if [ ! -f "gmapsupp.img" ]; then
    echo
    echo "Error: gmapsupp.img was not created"
    exit 1
fi

cp -f gmapsupp.img "$OUTPUT_DIR/$OUTPUT_IMG"

echo "✔ Garmin map built"
echo

echo "Output: $OUTPUT_DIR/$OUTPUT_IMG"
echo "Map name: EasyMaps / $DISPLAY_NAME"
echo
echo "=================================="
echo " Build completed successfully"
echo "=================================="