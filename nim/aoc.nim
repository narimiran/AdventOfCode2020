import strformat, strutils

type
  Solutions*[T, V] = object
    first*: T
    second*: V
  IntSolutions* = Solutions[int, int]

func `$`*[T, V](x: Solutions[T, V]): string =
  result = &"{x.first}\n{x.second}"

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
