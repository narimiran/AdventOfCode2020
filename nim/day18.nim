import aoc, streams

type
  Operation = enum
    opNone, opMul, opSum

template eval(expr) =
  let val = expr
  case operation
  of opNone: result = val
  of opSum: result += val
  of opMul:
    if part == 1: result *= val
    else:
      accum *= result
      result = val

proc parseExpression(s: Stream, part: int): int =
  var operation = opNone
  var accum = 1
  while not s.atEnd:
    let c  = s.readChar
    case c
    of '0'..'9': eval(ord(c) - ord('0'))
    of '(': eval(parseExpression(s, part))
    of ')': return result * accum
    of '*': operation = opMul
    of '+': operation = opSum
    else: discard
  result *= accum

proc solve(path: string): IntSolutions =
  for line in path.lines:
    result.first  += line.newStringStream.parseExpression 1
    result.second += line.newStringStream.parseExpression 2

echo solve "inputs/18.txt"
