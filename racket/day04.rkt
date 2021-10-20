#lang racket

(require threading)


(define all-passports
  (for/list ([passport (string-split (file->string "inputs/04.txt") "\n\n")])
    (for/hash ([pp-field (string-split passport)])
      (apply values (string-split pp-field ":")))))

(define (is-valid-1? ppt)
  (define pp-fields (hash-keys ppt))
  (for/and ([req (in-list '("byr" "iyr" "eyr" "hgt" "hcl" "ecl" "pid"))])
    (member req pp-fields)))

(define (is-valid-2? ppt)
  (for/and ([key (hash-keys ppt)])
    (define val (hash-ref ppt key))
    (match key
      ["byr" (<= 1920 (string->number val) 2002)]
      ["iyr" (<= 2010 (string->number val) 2020)]
      ["eyr" (<= 2020 (string->number val) 2030)]
      ["hgt"
       (cond
         [(string-suffix? val "cm") (~> val (string-trim "cm") string->number (<= 150 _ 193))]
         [(string-suffix? val "in") (~> val (string-trim "in") string->number (<=  59 _  76))])]
      ["hcl" (regexp-match #px"^#[[:xdigit:]]{6}$" val)]
      ["ecl" (member val '("amb" "blu" "brn" "gry" "grn" "hzl" "oth"))]
      ["pid" (regexp-match #px"^\\d{9}$" val)]
      ["cid" #t])))


(define valid-passports (filter is-valid-1? all-passports))

(length valid-passports)
(count is-valid-2? valid-passports)
