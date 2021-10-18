#lang racket


(define (parse-line line)
  (match (regexp-match #px"^(\\d+)-(\\d+) (\\w): (\\w+)$" line)
    [(list _ ; the whole match
           (app string->number lo)
           (app string->number hi)
           (app (compose1 first string->list) c)
           (app string->list pw))
     (list lo hi c pw)]))

(define ((valid? part) line)
  (match-define (list lo hi c pw) line)
  (match part
    [1 (define cnt (count (curry char=? c) pw))
       (<= lo cnt hi)]
    [2 (define (is-c? pos) (char=? c (list-ref pw (sub1 pos))))
       (xor (is-c? lo) (is-c? hi))]))


(define passwords (map parse-line (file->lines "inputs/02.txt")))
(count (valid? 1) passwords)
(count (valid? 2) passwords)
