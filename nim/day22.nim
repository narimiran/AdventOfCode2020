import strutils, deques, sets, sequtils

type
  Deck = Deque[int]

proc parse(path: string): (Deck, Deck) =
  let players = path.readFile.strip.split("\n\n").mapIt(it.splitLines)
  result[0] = players[0][1..^1].map(parseInt).toDeque
  result[1] = players[1][1..^1].map(parseInt).toDeque

template pickCards(p1, p2: var Deck; condition) =
  if condition:
    p1.addLast c1
    p1.addLast c2
  else:
    p2.addLast c2
    p2.addLast c1

func playRound(p1, p2: var Deck) =
  let c1 = p1.popFirst
  let c2 = p2.popFirst
  pickCards(p1, p2, c1 > c2)

func score(p: Deck): int =
  for i in 1 .. p.len:
    result += i * p[p.len-i]

func playGame(p1, p2: Deck): int =
  var p1 = p1
  var p2 = p2
  while p1.len > 0 and p2.len > 0:
    playRound(p1, p2)
  let winner = if p1.len > 0: p1 else: p2
  return winner.score

func playRecursive(p1, p2: Deck, joker: int, subgame = false): (int, int) =
  if subgame and joker in p1:
    ## P1 will be winner eventually. Return immediately.
    return (1, 0)
  var seen: HashSet[int]
  var p1 = p1
  var p2 = p2
  while p1.len > 0 and p2.len > 0:
    if seen.containsOrIncl(p1.score * p2.score):
      return (1, 0)
    let c1 = p1.popFirst
    let c2 = p2.popFirst
    if c1 > p1.len or c2 > p2.len:
      pickCards(p1, p2, c1 > c2)
    else:
      let np1 = toSeq(p1)[0..<c1].toDeque
      let np2 = toSeq(p2)[0..<c2].toDeque
      let (winner, _) = playRecursive(np1, np2, joker, subgame = true)
      pickCards(p1, p2, winner == 1)
  if p1.len > 0:
    return (1, p1.score)
  else:
    return (2, p2.score)


let (p1, p2) = parse "inputs/22.txt"
echo playGame(p1, p2)

## Find a "joker": a card with the highest value.
## If joker is held by Player 1, (s)he is the guaranteed winner of the game.
## This tremendously speeds up subgames - we don't need to
## play them as their score is not important.
let joker = max(concat(p1.toSeq, p2.toSeq))
echo playRecursive(p1, p2, joker)[1]
