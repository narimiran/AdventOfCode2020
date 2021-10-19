#lang racket


(define grid (file->lines "inputs/03.txt"))

(define h (length grid))
(define w (string-length (list-ref grid 0)))


(define (traverse right down)
  (for/sum ([y (in-range 0 h down)]
            [x (in-naturals)]
            #:when (char=? #\# (string-ref (list-ref grid y) (modulo (* x right) w))))
    1))

(define (solve slopes)
  (for/fold ([acc 1])
            ([slope (in-list slopes)])
    (* acc (apply traverse slope))))


(solve '((3 1)))
(solve '((1 1) (3 1) (5 1) (7 1) (1 2)))
