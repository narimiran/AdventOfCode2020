#lang racket


(define instructions
  (for/vector ([line (file->lines "inputs/08.txt")])
    (match-define (list instr val) (string-split line))
    (cons instr (string->number val))))

(define (run instructions)
  (define len (vector-length instructions))
  (define (aux accum seen i)
    (cond
      [(>= i len)           (cons #t accum)]
      [(set-member? seen i) (cons #f accum)]
      [else
       (match-define (cons instr val) (vector-ref instructions i))
       (match instr
         ["acc" (aux (+ val accum) (set-add seen i) (add1  i))]
         ["jmp" (aux        accum  (set-add seen i) (+ val i))]
         ["nop" (aux        accum  (set-add seen i) (add1  i))])]))
  (aux 0 '() 0))

(define (debug instructions)
  (for/or ([(instr idx) (in-indexed instructions)]
           #:when (member (car instr) '("jmp" "nop")))
    (define changed-instrs (vector-copy instructions))
    (define new-instr (if (string=? (car instr) "jmp") "nop" "jmp"))
    (vector-set! changed-instrs idx (cons new-instr (cdr instr)))
    (match (run changed-instrs)
      [(cons #t v)  v]
      [(cons #f _) #f])))


(cdr (run instructions))
(debug instructions)
