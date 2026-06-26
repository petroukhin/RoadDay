#!/bin/bash

BASE=/Users/petroukhinmac/Garmin/RoadDay

java -Xmx6G -jar /Users/petroukhinmac/Garmin/mkgmap/mkgmap-r4924/mkgmap.jar \
  --gmapsupp \
  --route \
  --index \
  $BASE/osm/*.osm.pbf
