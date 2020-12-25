import tables, sets, math


type
  Tile = tuple[p: int, q: int]
  Directions = seq[Tile]
  BlackTiles = CountTable[Tile]


func toAxial(direction: string): Tile =
  case direction
  of "nw": ( 0, -1)
  of "w":  (-1,  0)
  of "sw": (-1,  1)
  of "se": ( 0,  1)
  of "e":  ( 1,  0)
  of "ne": ( 1, -1)
  else: (0, 0)

func parseLine(line: string): Directions =
  var i = 0
  while i < line.len:
    case line[i]
    of 'w', 'e':
      result.add toAxial($line[i])
      inc i
    else:
      result.add toAxial(line[i..i+1])
      inc i, 2

proc parse(path: string): seq[Directions] =
  for line in path.lines:
    result.add parseLine(line)


func `+`(a, b: Tile): Tile = (a.p + b.p, a.q + b.q)

func initialize(directions: seq[Directions]): BlackTiles =
  for steps in directions:
    let dest = sum steps
    result[dest] = 1 - result[dest]

func playDay(blacks: BlackTiles): BlackTiles =
  let neighbours = [(0, -1), (-1, 0), (-1,  1),
                    (0,  1), ( 1, 0), ( 1, -1)]
  var seen: HashSet[Tile]
  for p1 in blacks.keys:
    for delta1 in neighbours:
      let p2 = p1 + delta1
      if seen.containsOrIncl(p2): continue
      var count: int
      for delta2 in neighbours:
        count += blacks[p2+delta2]
      if (blacks[p2] == 1 and count in {1, 2}) or
         (blacks[p2] == 0 and count == 2):
        result[p2] = 1

func play(seed: BlackTiles): int =
  var blackTiles = seed
  for _ in 1 .. 100:
    blackTiles = playDay(blackTiles)
  result = blackTiles.len


let input = parse "inputs/24.txt"
let seed = initialize input
echo seed.len
echo seed.play
