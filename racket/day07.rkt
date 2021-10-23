#lang racket

(require threading)


(define (parse-line line)
  (match-define (list bag contents) (string-split line " bags contain "))
  (define contains
    (for/list ([b (string-split contents ", ")]
               #:unless (string-prefix? b "no other"))
      (define bl (string-split b))
      (cons
       (string->number (first bl))
       (~> (rest bl) (take 2) string-join))))
  (values bag contains))

(define (parse-file path)
  (for/hash ([line (file->lines path)])
    (parse-line line)))

(define (contains-ours? contents)
  (define colors (map cdr (hash-ref bags contents)))
  (or
   (ormap (curry string=? "shiny gold") colors)
   (ormap contains-ours? colors)))

(define (inside-of current)
  (for/sum ([(amount color) (in-dict (hash-ref bags current))])
    (* amount (add1 (inside-of color)))))


(define bags (parse-file "inputs/07.txt"))

(count contains-ours? (hash-keys bags))
(inside-of "shiny gold")
