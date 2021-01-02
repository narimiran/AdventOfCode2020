import aoc, strutils

type
  Instruction = tuple[action: char, value: int]
  Instructions = seq[Instruction]

proc parse(path: string): Instructions =
  for line in path.lines:
    result.add (line[0], parseInt(line[1..^1]))

func solve(instructions: Instructions, part: int): int =
  var dir, pos = new Point
  dir[] = if part == Part1: (1, 0) else: (10, -1)
  pos[] = (0, 0)
  var movable = if part == Part1: pos else: dir
  for instr in instructions:
    case instr.action
    of 'E': movable.x += instr.value
    of 'W': movable.x -= instr.value
    of 'S': movable.y += instr.value
    of 'N': movable.y -= instr.value
    of 'F':
      pos.x += dir.x * instr.value
      pos.y += dir.y * instr.value
    of 'L':
      for _ in 1 .. (instr.value div 90):
        dir[] = (dir.y, -dir.x)
    of 'R':
      for _ in 1 .. (instr.value div 90):
        dir[] = (-dir.y, dir.x)
    else: discard
  result = manhattan pos[]


let input = parse "inputs/12.txt"
echo input.solve Part1
echo input.solve Part2
