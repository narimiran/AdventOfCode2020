func solve(a, b, m: int): int =
  var subject = 1
  result = 1
  while subject != a:
    subject = 7 * subject mod m
    result = b * result mod m


let card = 1526110
let door = 20175123
let modulo = 20201227

echo solve(card, door, modulo)
