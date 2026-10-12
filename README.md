# GstarCAD Region Tools

Turn closed curves into regions, run union, subtract and intersect on region sets, and total their areas.

Works with **GSTARCAD**, AutoCAD, ZWCAD, and BricsCAD.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Contents

- [About](#about)
- [Scripts Overview](#scripts-overview)
- [Quick Start](#quick-start)
- [Compatibility](#compatibility)
- [Contributing](#contributing)
- [License](#license)

## About

Regions are the cleanest way to do area maths and boolean geometry in CAD. These utilities turn closed polylines into regions, run union, subtract and intersect on two selections with a single command, and total the area of a whole set of regions.

Everything here is free to use with GstarCAD. Download the latest GstarCAD
release from the [official GstarCAD website](https://www.gstarcad.net). All
scripts are tested with **[GSTARCAD](https://www.gstarcad.net)** and major
DWG-based CAD platforms.

## Scripts Overview

| File | Description |
|------|-------------|
| `scripts/region-from-pline.lsp` | ;; region-from-pline.lsp - Create regions from closed curves
;; Command: REGIONPL
;; Usage: select closed polylines (or circles, ellipses, splines)
(defun c:REGIONPL ( / ss i en n )
  (setq ss (ssget '((0 . "LWPOLYLINE,POLYLINE,CIRCLE,ELLIPSE,SPLINE"))))
  (if ss
    (progn
      (setq i 0 n 0)
      (repeat (sslength ss)
        (setq en (ssname ss i))
        (command "_.REGION" en "")
        (setq n (1+ n) i (1+ i))
      )
      (princ (strcat "\nRegions created: " (itoa n)))
    )
  )
  (princ)
)
 |
| `scripts/region-boolean.lsp` | ;; region-boolean.lsp - Union, subtract or intersect two region sets
;; Command: RBOOL
;; Usage: RBOOL -> choose U/S/I -> first set -> second set
(defun c:RBOOL ( / opt ssa ssb )
  (initget "U S I")
  (setq opt (getkword "\nBoolean [U=Union/S=Subtract/I=Intersect] <U>: "))
  (if (null opt) (setq opt "U"))
  (setq ssa (ssget "\nSelect the first set of regions: "))
  (if ssa
    (progn
      (setq ssb (ssget "\nSelect the second set of regions: "))
      (if ssb
        (cond
          ((= opt "U") (command "_.UNION" ssa ssb ""))
          ((= opt "S") (command "_.SUBTRACT" ssa "" ssb ""))
          ((= opt "I") (command "_.INTERSECT" ssa ssb ""))
        )
      )
    )
  )
  (princ)
)
 |
| `scripts/region-area-total.lsp` | ;; region-area-total.lsp - Total area of selected regions
;; Command: RAREA
(defun c:RAREA ( / ss i en total )
  (setq ss (ssget '((0 . "REGION"))))
  (if ss
    (progn
      (setq i 0 total 0.0)
      (repeat (sslength ss)
        (setq en (ssname ss i))
        (command "_.AREA" "_O" en)
        (setq total (+ total (getvar "AREA")))
        (setq i (1+ i))
      )
      (princ (strcat "\nRegions: " (itoa (sslength ss))
                     "  Total area: " (rtos total 2 2)))
    )
  )
  (princ)
)
 |

## Quick Start

1. Download the `.lsp` (or `.lin`) file you need
2. In your CAD software, run `APPLOAD`
3. Load the file and type the matching command name shown in the table above

## Compatibility

Tested on GstarCAD 2026/2027 and similar DWG-based platforms. Scripts use
standard AutoLISP functions only, so they work without extra plugins.

For step-by-step [tutorials and drafting guides](https://www.gstarcad.net/cad/),
visit the GstarCAD learning center. New tips are published regularly on the
[GSTARCAD Blog](https://blog.gstarcad.net).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT — see the [LICENSE](LICENSE) file.
