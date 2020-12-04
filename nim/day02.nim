import strutils, strscans

proc solve(input: string): (int, int) =
  var
    lo, hi: int
    l, w: string
  for line in input.lines:
    if line.scanf("$i-$i $w: $w", lo, hi, l, w):
      let c = l[0]
      if w.count(c) in lo..hi: inc result[0]
      if w[lo-1] == c xor w[hi-1] == c: inc result[1]

echo solve "inputs/02.txt"
