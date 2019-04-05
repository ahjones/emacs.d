(setq phrasebook-highlights
      '(("^[^=]+" . font-lock-function-name-face)
        ("{[^}]+}" . font-lock-constant-face)))

(define-derived-mode phrasebook-mode fundamental-mode "phrasebook"
  "major mode for editing phrasebooks."
  (setq font-lock-defaults '(phrasebook-highlights)))

(provide 'phrasebook-mode)
