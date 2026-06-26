# EasyMaps Usage Guide

EasyMaps is a tool for building custom Garmin maps from OpenStreetMap data.

It does NOT provide maps.
It provides a rendering pipeline to generate your own Garmin-compatible maps using a custom style.

---

# 🧠 What this tool is

EasyMaps is a full map rendering pipeline:

Input:
- OpenStreetMap .osm.pbf files

Processing:
- splitter (splits map into tiles)
- mkgmap (builds Garmin .img)
- EasyMaps style (map rendering rules)
- EasyMaps TYP (colors, icons, labels)

Output:
- Garmin .img file

---

# ⚙️ Requirements

You need:

- Java 17+
- mkgmap (tested with r4924)
- splitter (tested with r654)

---

# 📁 Project structure

EasyMaps/
├── build.sh
├── style/EasyMaps/
├── typ/EasyMaps.txt
├── typ/EasyMaps.typ
├── docs/

External tools:

../mkgmap/mkgmap-r4924/
../splitter-r654/

---

# 🚴 How to use

## 1. Get OpenStreetMap data

Download .osm.pbf from:

https://download.geofabrik.de/

Example:

kaliningrad-latest.osm.pbf

---

## 2. Build map

Run:

./build.sh path/to/map.osm.pbf

Example:

./build.sh ~/Downloads/kaliningrad-260625.osm.pbf

---

## 3. Output

Result:

build/output/EasyMaps-<region>.img

Map name inside Garmin:

EasyMaps / <Region>

---

# 🎨 Customization

## Style
Edit:
style/EasyMaps/

Controls rendering of roads, landuse, POIs and map appearance.

## TYP file
Edit:
typ/EasyMaps.txt

defines icons, colors and labels.

---

# 🧭 Philosophy

EasyMaps is NOT a map provider.

It is a reproducible pipeline for generating Garmin maps with a consistent visual style.

You bring your own OpenStreetMap data.

---

# ⚠️ Notes

- Tested only on Garmin Edge 1050
- Other devices may behave differently
- Large maps may require more RAM

---

# 🪟 Windows support

EasyMaps is platform-independent and can be used on Windows with a few setup options.

## Recommended: WSL (Windows Subsystem for Linux)

This is the most stable way to run EasyMaps on Windows.

Steps:
- Install WSL (Ubuntu recommended)
- Install Java 17+
- Install mkgmap and splitter inside WSL
- Clone EasyMaps repo inside WSL filesystem
- Run:

```
./build.sh path/to/map.osm.pbf
```

## Alternative: Git Bash

You can also use Git Bash:
- Install Git for Windows
- Run build.sh from Git Bash terminal

Note: some paths may need adjustment.

## Important notes

- Native Windows CMD/PowerShell is NOT recommended
- WSL provides closest Linux behavior and best compatibility
- Java + tools must be accessible from the same environment

---

## 🧭 Usage

This project provides a custom Garmin map rendering pipeline based on OpenStreetMap.

It does NOT provide ready-made maps.

It is a tool for building your own Garmin maps using a custom style and TYP configuration.

### How to use

See full usage guide:

USAGE.md

---

If you want to build your own map:
- provide your own OpenStreetMap .osm.pbf file
- run ./build.sh
- get a Garmin .img output

---
