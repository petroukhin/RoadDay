# EasyMaps

Build clean and readable Garmin maps from OpenStreetMap.

> **Current version:** v1.1.0

EasyMaps combines a custom mkgmap style and a custom Garmin TYP theme to produce maps optimized for cycling. The project is currently developed and tested on the Garmin Edge 1050. Compatibility with older Garmin devices has not yet been verified.

## Why EasyMaps?

EasyMaps is designed for cyclists who want a clean, readable Garmin map without unnecessary visual clutter. The style focuses on roads, routing and readability while riding.

## Preview

![EasyMaps Preview](docs/images/preview.png)

---

## Installation

If you only want to use EasyMaps on your Garmin device, see the installation guide:

`INSTALL.md` *(coming soon)*

If you want to build your own Garmin maps from OpenStreetMap, continue reading this document.

---

## Requirements

Before building a map, make sure the following are available:

- Java
- mkgmap
- splitter

Expected project layout:

```text
EasyMaps/
├── build.sh
├── style/
├── typ/
├── README.md
└── CHANGELOG.md

../mkgmap/
└── mkgmap-r4924/

../splitter-r654/
└── splitter.jar
```

---

## Build

Run:

```bash
./build.sh /path/to/map.osm.pbf
```

Example:

```bash
./build.sh ~/Downloads/kaliningrad-260625.osm.pbf
```

---

## Output

Generated file:

```text
build/output/EasyMaps-<region>.img
```

Garmin map name:

```text
EasyMaps / <Region>
```

---

## Features

- Optimized for road cycling
- Custom Garmin TYP theme
- Custom mkgmap style
- Automatic map splitting
- Automatic TYP compilation
- Automatic Garmin IMG generation
- Automatic map naming
- Automatic output file naming
- Tested on Garmin Edge 1050

---

## Roadmap

- Verify compatibility with older Garmin devices
- Improve zoom levels
- Improve POI rendering
- Automatic installation to Garmin (`--install`)
- Multi-region build support
- Windows and Linux support

---

## Documentation

- `INSTALL.md` — Install EasyMaps on your Garmin device *(coming soon)*
- `BUILD.md` — Build your own Garmin maps *(planned)*
- `CHANGELOG.md` — Release history