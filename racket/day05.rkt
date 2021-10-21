#lang racket

(require threading)


(define (seat->bit seat)
  (for/list ([c (in-string seat)])
    (match c
      [(or #\B #\R) #\1]
      [else #\0])))

(define (seat->nr seat)
  (~> seat
      seat->bit
      list->string
      (string->number 2)))

(define seats
  (~> "inputs/05.txt"
      file->lines
      (map seat->nr _)
      (sort >)))


(first seats)
(for/first ([a seats]
            [b (cdr seats)]
            #:unless (= (sub1 a) b))
  (sub1 a))
