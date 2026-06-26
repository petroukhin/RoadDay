#!/bin/bash

set -e

echo "=================================="
echo " RoadDay Build"
echo "=================================="


BASE="$(cd "$(dirname "$0")" && pwd)"

PBF_FILE="$1"

if [ -z "$PBF_FILE" ]; then
    echo ""
    echo "Usage: ./build.sh <map.osm.pbf>"
    exit 1
fi

if [ ! -f "$PBF_FILE" ]; then
    echo ""
    echo "Error: PBF file not found: $PBF_FILE"
    exit 1
fi

BUILD_DIR="$BASE/build"
SPLIT_DIR="$BUILD_DIR/split"

rm -rf "$SPLIT_DIR"
mkdir -p "$SPLIT_DIR"

echo "[1/3] Splitting map..."
echo "Using PBF: $PBF_FILE"

cd "$SPLIT_DIR"

echo "Current directory:"
pwd

echo ""
echo "Files before splitter:"
ls -la
echo ""

java -Xmx4G -jar "$BASE/../../splitter-r654/splitter.jar" --mapid=63240001 --output=pbf "$PBF_FILE"

if [ ! -f "template.args" ]; then
    echo ""
    echo "Error: template.args not found after splitting."
    exit 1
fi

echo ""
echo "Files after splitter:"
pwd
ls -la
echo ""

echo "✔ Map split"

echo ""
echo "[2/3] Compiling TYP..."

java -cp "$BASE/../../mkgmap/mkgmap-r4924/mkgmap.jar" uk.me.parabola.mkgmap.main.TypCompiler "$BASE/typ/RoadDay.txt" "$BASE/typ/RoadDay.typ"

echo "✔ TYP compiled"

echo ""
echo "[3/3] Building Garmin map..."

java -Xmx4G -jar "$BASE/../../mkgmap/mkgmap-r4924/mkgmap.jar" \
  --style-file="$BASE/style" \
  --style=RoadDay \
  --family-id=10010 \
  --product-id=1 \
  --family-name="RoadDay" \
  --series-name="RoadDay" \
  --overview-mapname=ROADDAY \
  --route \
  --gmapsupp \
  -c template.args \
  "$BASE/typ/RoadDay.typ"

cp gmapsupp.img "$BASE/gmapsupp.img"

echo ""
echo "=================================="
echo " Done!"
echo "=================================="
echo ""
echo "gmapsupp.img created successfully"