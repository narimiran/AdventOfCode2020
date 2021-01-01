import intsets


type
  Point4d = int
  Grid4d = IntSet

proc toPoint(x, y, z, w: int): Point4d {.inline.} =
  ## Converts what would be a `(x, y, z, w)` tuple into
  ## a unique integer via powers of 17.
  4913*x + 289*y + 17*z + w

proc parse(input: string): Grid4d =
  var y: int
  for line in input.lines:
    for x, c in line:
      if c == '#':
        result.incl toPoint(x, y, 0, 0)
    inc y

template allDirections(dims: int, body: untyped) {.dirty.} =
  let deltas = [-1, 0, 1]
  let deltasW = if dims == 3: @[0] else: @[-1, 0, 1]
  for dx in deltas:
    for dy in deltas:
      for dz in deltas:
        for dw in deltasW:
          body

proc countNeighbours(grid: Grid4d, p: Point4d, dims: int): int =
  allDirections(dims):
    result += ord((p + toPoint(dx, dy, dz, dw)) in grid)

proc nextGeneration(grid: Grid4d, dims: int): Grid4d =
  var seen: Grid4d
  for p1 in grid:
    allDirections(dims):
      let p2 = p1 + toPoint(dx, dy, dz, dw)
      if not seen.containsOrIncl p2:
        let count = grid.countNeighbours(p2, dims)
        if count == 3 or (p2 in grid and count == 4):
          result.incl p2

proc cycle(grid: Grid4d, dims: int): int =
  var grid = grid
  for _ in 1 .. 6:
    grid = grid.nextGeneration(dims)
  result = grid.card

var grid = parse "inputs/17.txt"
echo grid.cycle(3)
echo grid.cycle(4)
