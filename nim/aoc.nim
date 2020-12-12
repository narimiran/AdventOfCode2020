import strformat, strutils

const
  Part1* = 1
  Part2* = 2

type
  Solutions*[T, V] = object
    first*: T
    second*: V
  IntSolutions* = Solutions[int, int]
  Point* = tuple[x, y: int]
  Points* = seq[Point]

func `$`*[T, V](x: Solutions[T, V]): string =
  result = &"{x.first}\n{x.second}"

func `+`*(a, b: Point): Point =
  (a.x + b.x, a.y + b.y)

func `+=`*(a: var Point, b: Point) =
  a.x += b.x
  a.y += b.y

func manhattan*(p: Point): int =
  result = abs(p.x) + abs(p.y)


proc parseIntSeq*(path: string): seq[int] =
  for line in path.lines:
    result.add parseInt(line)

func createEmptyGrid*[T](rows, cols: int): seq[seq[T]] =
  for i in 0 ..< rows:
    result.add @[]
    for j in 0 ..< cols:
      result[^1].add default(T)

func resetGrid*[T](xs: var seq[seq[T]]) =
  for line in xs.mitems:
    zeroMem(line[0].addr, sizeof(T) * line.len)
