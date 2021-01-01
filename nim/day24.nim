import math


type
  Tile = int
  Directions = seq[Tile]
  TileSet = set[-8888..8888]

const
  neighbours = [-1, -128, -127, 1, 128, 127]
  ## Every direction would be a `(p, q)` tuple, which is now
  ## converted into an `int` via `128*p + q`.

func toAxial(direction: string): Tile =
  case direction
  of "nw": neighbours[0]   # ( 0, -1)
  of "w":  neighbours[1]   # (-1,  0)
  of "sw": neighbours[2]   # (-1,  1)
  of "se": neighbours[3]   # ( 0,  1)
  of "e":  neighbours[4]   # ( 1,  0)
  of "ne": neighbours[5]   # ( 1, -1)
  else: 0

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


func initialize(directions: seq[Directions]): TileSet =
  for steps in directions:
    let dest = sum steps
    if dest in result:
      result.excl dest
    else:
      result.incl dest

func playDay(blacks: TileSet): TileSet =
  var seen: TileSet
  for p1 in blacks:
    for delta1 in neighbours:
      let p2 = p1 + delta1
      if p2 in seen: continue
      seen.incl p2
      var count: int
      for delta2 in neighbours:
        count += ord(p2+delta2 in blacks)
      if p2 in blacks:
        if count in {1, 2}:
          result.incl p2
      elif count == 2:
        result.incl p2

func play(seed: TileSet): int =
  var blackTiles = seed
  for _ in 1 .. 100:
    blackTiles = playDay(blackTiles)
  result = blackTiles.len


let input = parse "inputs/24.txt"
let seed = initialize input
echo seed.len
echo seed.play
