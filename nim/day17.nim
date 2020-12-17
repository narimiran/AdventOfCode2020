import sets

type
  Point4d = tuple[x, y, z, w: int]
  Grid4d = HashSet[Point4d]

proc parse(input: string): Grid4d =
  var y: int
  for line in input.lines:
    for x, c in line:
      if c == '#':
        result.incl (x, y, 0, 0)
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
    result += ord((p.x+dx, p.y+dy, p.z+dz, p.w+dw) in grid)

proc nextGeneration(grid: Grid4d, dims: int): Grid4d =
  var seen: Grid4d
  for p1 in grid:
    allDirections(dims):
      let p2: Point4d = (p1.x+dx, p1.y+dy, p1.z+dz, p1.w+dw)
      if p2 notin seen:
        seen.incl p2
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
