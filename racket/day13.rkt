#lang racket


(define instructions (file->lines "inputs/13.txt"))
(define timestamp (string->number (first instructions)))

(define buses
  (for/list ([(bus idx) (in-indexed (string-split (second instructions) ","))]
             #:unless (string=? bus "x"))
    (cons idx (string->number bus))))

(define (part-1)
  (for/fold ([earliest +inf.0]
             [result 0]
             #:result result)
            ([(_ bus) (in-dict buses)])
    (define wait (modulo (- timestamp) bus))
    (if (< wait earliest)
        (values wait (* bus wait))
        (values earliest result))))

(define (part-2)
  (define (lcm2 res prime i bus)
    (for/first ([n (in-range res (* prime bus) prime)]
                #:when (= (modulo (+ n i) bus) 0))
      n))
  (for/fold ([prime 1]
             [res 0]
             #:result res)
            ([(i bus) (in-dict buses)])
    (values (* prime bus) (lcm2 res prime i bus))))


(part-1)
(part-2)
