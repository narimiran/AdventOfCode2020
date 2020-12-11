import aoc, strutils

type
  Seat = enum
    Floor = "."
    Empty = "L"
    Occup = "#"
    NoSeat
  Seats = seq[seq[Seat]]
  Point = tuple[x, y: int]
  Visible = seq[Point]
  VisibleGrid = seq[seq[Visible]]
  CountsGrid = seq[seq[int]]

proc parse(path: string): Seats =
  for line in path.lines:
    result.add @[]
    for c in line:
      result[^1].add parseEnum[Seat]($c)

func neighbour(seats: Seats, x, y, dx, dy: int): Seat =
  let (nx, ny) = (x + dx, y + dy)
  if ny >= 0 and ny < seats.len and
     nx >= 0 and nx < seats[ny].len:
    return seats[ny][nx]
  else:
    return NoSeat

func getVisibleFromPoint(seats: Seats, x, y: int, adjacent: bool): Visible =
  let directions = [( 1, 0), ( 1,  1), (0,  1), (-1,  1),
                    (-1, 0), (-1, -1), (0, -1), ( 1, -1)]
  for (dx, dy) in directions:
    var nearby = Floor
    var n = 0
    while nearby == Floor:
      inc n
      nearby = seats.neighbour(x, y, n*dx, n*dy)
      if adjacent: break
    if nearby in {Empty, Occup}:
      result.add (x+n*dx, y+n*dy)

func getAllVisible(seats: Seats, adjacent: bool): VisibleGrid =
  result = createEmptyGrid[Visible](seats.len, seats[0].len)
  for y in 0 ..< seats.len:
    for x in 0 ..< seats[0].len:
      if seats[y][x] in {Empty, Occup}:
        result[y][x] = seats.getVisibleFromPoint(x, y, adjacent)

func nextGeneration(seats: var Seats, counts: var CountsGrid,
                    visibles: VisibleGrid, part: int): bool =
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
  let visibles = getAllVisible(seats, part==1)
  var counts = createEmptyGrid[int](seats.len, seats[0].len)
  while nextGeneration(seats, counts, visibles, part):
    resetGrid counts
  for row in seats:
    for seat in row:
      if seat == Occup:
        inc result


let seats = parse "inputs/11.txt"

echo seats.solve 1
echo seats.solve 2
