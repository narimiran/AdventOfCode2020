#lang racket

(require threading)


(define (parse path)
  (define groups (~> path file->string (string-split "\n\n")))
  (for/list ([group (in-list groups)])
    (for/list ([person (in-list (string-split group))])
      (for/set ([c (in-string person)]) c))))

(define (solve groups func)
  (for/sum ([group (in-list groups)])
    (set-count (apply func group))))


(define answers (parse "inputs/06.txt"))
(solve answers set-union)
(solve answers set-intersect)
