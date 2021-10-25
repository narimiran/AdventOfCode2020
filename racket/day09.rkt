#lang racket

(require threading)


(define instructions
  (~>> "inputs/09.txt"
       file->lines
       (map string->number)
       list->vector))


(define (is-sum? prevs sum)
  (for*/or ([a prevs]
            [b prevs])
    (= (+ a b) sum)))

(define (find-invalid [instr instructions])
  (define (prevs idx)
    (vector-take (vector-drop instr (- idx 25)) 25))
  (for/first ([(val idx) (in-indexed instr)]
              #:when (> idx 25)
              #:unless (is-sum? (prevs idx) val))
    val))

(define (sum-to goal [lo 0] [hi 2] [instr instructions])
  (define slice
    (~> instr
        (vector-take hi)
        (vector-drop lo)
        vector->list))
  (define total (apply + slice))
  (cond
    [(< total goal) (sum-to goal lo (add1 hi))]
    [(> total goal) (sum-to goal (add1 lo) hi)]
    [else (+ (apply min slice) (apply max slice))]))


(define invalid (find-invalid))

invalid
(sum-to invalid)
