;; region-boolean.lsp - Union, subtract or intersect two region sets
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
