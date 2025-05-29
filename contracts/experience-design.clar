;; Experience Design Contract
;; Manages holographic shopping experiences

(define-data-var admin principal tx-sender)
(define-map experiences uint {designer: principal, metadata: (string-utf8 256), active: bool})
(define-data-var experience-counter uint u0)

(define-public (register-experience (metadata (string-utf8 256)))
  (let ((exp-id (var-get experience-counter)))
    (asserts! (> (len metadata) u0) (err u101))
    (map-set experiences exp-id {designer: tx-sender, metadata: metadata, active: true})
    (var-set experience-counter (+ exp-id u1))
    (ok exp-id)))

(define-public (deactivate-experience (exp-id uint))
  (let ((experience (unwrap! (map-get? experiences exp-id) (err u102))))
    (asserts! (is-eq tx-sender (get designer experience)) (err u103))
    (map-set experiences exp-id (merge experience {active: false}))
    (ok true)))

(define-read-only (get-experience (exp-id uint))
  (map-get? experiences exp-id))
