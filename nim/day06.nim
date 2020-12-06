import strutils

proc solve(path: string): (int, int) =
  for group in (readFile path).strip.split("\n\n"):
    var any: set[char]
    var all = {'a'..'z'}
    for person in group.splitLines:
      var answers: set[char]
      for c in person: answers.incl c
      any = any + answers
      all = all * answers
    result[0] += any.card
    result[1] += all.card

echo solve "inputs/06.txt"
