import sequtils

func traverse(grid: seq[string], right, down: int): int =
  var x: int
  for y in countup(0, grid.high, down):
    if grid[y][x] == '#': inc result
    x = (x + right) mod grid[0].len

func part2(grid: seq[string]): int =
  result = traverse(grid, 1, 2)
  for right in [1, 3, 5, 7]:
    result *= traverse(grid, right, 1)

let grid = toSeq("inputs/03.txt".lines)
echo traverse(grid, 3, 1)
echo part2(grid)
