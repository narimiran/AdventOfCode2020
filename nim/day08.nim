import strutils

type
  Instruction = enum
    acc, jmp, nop
  Instructions = seq[(Instruction, int)]

proc parse(path: string): Instructions =
  for line in path.lines:
    result.add (parseEnum[Instruction](line[0..2]), parseInt(line[4..^1]))

func part1(input: Instructions): (bool, int) =
  var seen: set[int16]
  var line = 0'i16
  var accum: int
  while true:
    if line in seen: return (false, accum)
    if line >= input.len: return (true, accum)
    seen.incl line
    let inst = input[line]
    case inst[0]
    of nop: inc line
    of jmp: inc line, inst[1]
    of acc:
      accum.inc inst[1]
      inc line

func part2(input: var Instructions): int =
  func change(s: var Instruction) =
    s = if s == nop: jmp else: nop
  for i in 0 ..< input.len:
    if input[i][0] in {jmp, nop}:
      change input[i][0]
      let f = part1(input)
      if f[0]: return f[1]
      change input[i][0]


var instructions = parse "inputs/08.txt"

echo part1(instructions)[1]
echo part2(instructions)
