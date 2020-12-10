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
