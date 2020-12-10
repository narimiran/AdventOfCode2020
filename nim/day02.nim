import aoc, strutils, strscans

proc solve(input: string): IntSolutions =
  var
    lo, hi: int
    c: char
    w: string
  for line in input.lines:
    if line.scanf("$i-$i $c: $w", lo, hi, c, w):
      if w.count(c) in lo..hi: inc result.first
      if w[lo-1] == c xor w[hi-1] == c: inc result.second

echo solve("inputs/02.txt")
