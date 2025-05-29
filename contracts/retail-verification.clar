;; Retailer Verification Contract
;; Validates holographic commerce providers

(define-data-var admin principal tx-sender)
(define-map verified-retailers principal bool)

(define-public (register-retailer (retailer principal))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u100))
    (ok (map-set verified-retailers retailer true))))

(define-public (revoke-retailer (retailer principal))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u100))
    (ok (map-set verified-retailers retailer false))))

(define-read-only (is-verified-retailer (retailer principal))
  (default-to false (map-get? verified-retailers retailer)))

(define-public (transfer-admin (new-admin principal))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u100))
    (ok (var-set admin new-admin))))
