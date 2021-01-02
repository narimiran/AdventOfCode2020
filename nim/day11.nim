import aoc, strutils

type
  Seat = enum
    Floor = "."
    Empty = "L"
    Occup = "#"
    NoSeat
  Point = tuple[x, y: int8]
  Seats = seq[seq[Seat]]
  Visible = seq[Point]
  VisibleGrid = seq[seq[Visible]]
  CountsGrid = seq[seq[int8]]

proc parse(path: string): Seats =
  for line in path.lines:
    result.add @[]
    for c in line:
      result[^1].add parseEnum[Seat]($c)

func neighbour(seats: Seats, nx, ny: int): Seat =
  if ny >= 0 and ny < seats.len and
     nx >= 0 and nx < seats[0].len:
    return seats[ny][nx]
  else:
    return NoSeat

iterator getVisibleFromPoint(seats: Seats, x, y: int8, adjacent: bool): Point =
  let directions = [(1'i8, 0'i8), (1'i8,  1'i8), (0'i8, 1'i8), (-1'i8, 1'i8)]
  for (dx, dy) in directions:
    var nearby = Floor
    var n = 0'i8
    while nearby == Floor:
      inc n
      nearby = seats.neighbour(x+n*dx, y+n*dy)
      if adjacent: break
    if nearby in {Empty, Occup}:
      yield (x+n*dx, y+n*dy)

func getAllVisible(seats: Seats, adjacent: bool): VisibleGrid =
  result = createEmptyGrid[Visible](seats.len, seats[0].len)
  for y in 0'i8 ..< seats.len.int8:
    for x in 0'i8 ..< seats[0].len.int8:
      if seats[y][x] in {Empty, Occup}:
        for (nx, ny) in seats.getVisibleFromPoint(x, y, adjacent):
          result[y][x].add (nx, ny)
          result[ny][nx].add (x, y)

func nextGeneration(seats: var Seats, counts: var CountsGrid,
                    visibles: VisibleGrid, part: int): bool =
  resetGrid counts
  for y in 0 ..< seats.len:
    for x in 0 ..< seats[0].len:
      if seats[y][x] == Occup:
        for (vx, vy) in visibles[y][x]:
          inc counts[vy][vx]
  for y, line in seats.mpairs:
    for x, seat in line.mpairs:
      if seat != Floor:
        if seat == Empty and counts[y][x] == 0:
          seat = Occup
          result = true
        elif seat == Occup and counts[y][x] >= 3 + part:
          seat = Empty
          result = true

func solve(seats: Seats, part: int): int =
  var seats = seats
  let visibles = getAllVisible(seats, part==Part1)
  var counts = createEmptyGrid[int8](seats.len, seats[0].len)
  while nextGeneration(seats, counts, visibles, part): discard
  for row in seats:
    for seat in row:
      if seat == Occup:
        inc result


let seats = parse "inputs/11.txt"

echo seats.solve Part1
echo seats.solve Part2
