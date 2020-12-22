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

func until(d: Deck, x: int): Deck =
  result = initDeque[int](x)
  for i in 0 ..< x:
    result.addLast(d[i])

func max(d: Deque[int]): int =
  for i in d:
    result = max(result, i)

func playRecursive(p1, p2: Deck): int =
  var seen: HashSet[int]
  var p1 = p1
  var p2 = p2
  while p1.len > 0 and p2.len > 0:
    if seen.containsOrIncl(p1.score * p2.score):
      return 1
    let c1 = p1.popFirst
    let c2 = p2.popFirst
    if c1 > p1.len or c2 > p2.len:
      pickCards(p1, p2, c1 > c2)
    else:
      let np1 = p1.until(c1)
      let np2 = p2.until(c2)
      let winner =
        if max(np1) > max(np2): 1 # P1 always wins if (s)he has the highest card
        else: playRecursive(np1, np2)
      pickCards(p1, p2, winner == 1)
  if p1.len > 0:
    return p1.score
  else:
    return p2.score


let (p1, p2) = parse "inputs/22.txt"
echo playGame(p1, p2)
echo playRecursive(p1, p2)
