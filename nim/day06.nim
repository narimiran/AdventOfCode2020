import aoc, strutils

proc solve(path: string): IntSolutions =
  for group in (readFile path).strip.split("\n\n"):
    var any: set[char]
    var all = {'a'..'z'}
    for person in group.splitLines:
      var answers: set[char]
      for c in person: answers.incl c
      any = any + answers
      all = all * answers
    result.first += any.card
    result.second += all.card

echo solve "inputs/06.txt"
