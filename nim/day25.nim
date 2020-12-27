proc loopSize(key: int): int =
  var subject = 1
  while true:
    inc result
    subject = (7 * subject) mod 20201227
    if subject == key:
      break

proc transform(key, loop: int): int =
  result = 1
  for _ in 1 .. loop:
    result = (result * key) mod 20201227


let card = 1526110
let door = 20175123

echo door.transform(card.loopSize)

