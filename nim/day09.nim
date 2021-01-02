import aoc

const PreambleLength = 25

func isSum(input: seq[int], i: int): bool =
  for a in i-PreambleLength ..< i:
    for b in a+1 ..< i:
      if input[a] + input[b] == input[i]:
        return true

func part1(input: seq[int]): int =
  for i in PreambleLength ..< input.len:
    if not isSum(input, i):
      return input[i]

func part2(input: seq[int], goal: int): int =
  var lo = 0
  var hi = 1
  var total = input[lo] + input[hi]
  while total != goal:
    if total < goal:
      inc hi
      total += input[hi]
    else:
      total -= input[lo]
      inc lo
  return min(input[lo..hi]) + max(input[lo..hi])

let input = parseIntSeq "inputs/09.txt"
let p1 = part1(input)

echo p1
echo part2(input, p1)
