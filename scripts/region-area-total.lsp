;; region-area-total.lsp - Total area of selected regions
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
