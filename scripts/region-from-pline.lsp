;; region-from-pline.lsp - Create regions from closed curves
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
