#lang racket

(require threading)


(define adapters
  (~>> "inputs/10.txt"
       file->lines
       (map string->number)
       (cons 0)
       ((λ (xs) (cons (+ 3 (apply max xs)) xs)))
       (sort _ <)))

(define differences
  (map -
       (rest adapters)
       (drop-right adapters 1)))

(define (consecutive-ones diffs)
  (for/fold ([prev-ones 0]
             [acc '()]
             #:result acc)
            ([d diffs])
    (cond
      [(= d 1)         (values (add1 prev-ones) acc)]
      [(= prev-ones 0) (values prev-ones acc)]
      [else            (values 0 (cons prev-ones acc))])))

(define/match (group-combinations x)
  [(1) 1]
  [(2) 2]
  [(3) 4]
  [(4) 7]
  [(5) 13])


(~>> differences
     (group-by (curry = 1))
     (map length)
     (apply *))

(~>> differences
     consecutive-ones
     (map group-combinations)
     (apply *))
