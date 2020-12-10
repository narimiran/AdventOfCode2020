import aoc, tables, algorithm

func solve(adapters: seq[int]): IntSolutions =
  var
    joltages = sorted adapters
    ones, threes: int
    ways = [0].toCountTable
  let largestAdapter = joltages[^1]
  joltages.add largestAdapter+3
  for i, jolt in joltages:
    if i == joltages.high: break
    case joltages[i+1] - jolt
    of 1: inc ones
    of 3: inc threes
    else: discard
    ways[jolt] = ways[jolt-3] + ways[jolt-2] + ways[jolt-1]
  result.first = ones * threes
  result.second = ways[largestAdapter]

let adapters = parseIntSeq "inputs/10.txt"
echo solve(adapters)
