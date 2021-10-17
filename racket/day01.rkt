#lang racket


(define (solve numbers part)
  (for/first ([combo (in-combinations numbers (add1 part))]
              #:when (= 2020 (apply + combo)))
    (apply * combo)))


(define numbers (map string->number (file->lines "inputs/01.txt")))
(solve numbers 1)
(solve numbers 2)
