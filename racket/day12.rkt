#lang racket


(define instructions
  (for/list ([line (file->lines "inputs/12.txt")])
    (match-define (list _ action val) (regexp-match #px"(\\w)(\\d+)" line))
    (cons (string->symbol action) (string->number val))))

(define (manhattan pos)
  (+ (abs (real-part pos)) (abs (imag-part pos))))

(define (solve part start)
  (for/fold ([pos 0]
             [dir start]
             #:result (manhattan pos))
            ([(action val) (in-dict instructions)])
    (case action
      [(F)
       (values (+ pos (* val dir)) dir)]
      [(L R)
       (define rot (if (eq? action 'L) +i -i))
       (values pos (* dir (expt rot (/ val 90))))]
      [(N E S W)
       (define/match (move action)
         [('N) +i]
         [('E)  1]
         [('S) -i]
         [('W) -1])
       (define delta (* val (move action)))
       (if (= part 1) (values (+ pos delta) dir) (values pos (+ dir delta)))])))


(solve 1 1)
(solve 2 10+i)
