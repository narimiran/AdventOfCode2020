import aoc

func products(s: seq[int]): IntSolutions =
  for i in 0 ..< s.len:
      for j in i+1 ..< s.len:
        if s[i] + s[j] == 2020:
          result.first = s[i] * s[j]
        elif s[i] + s[j] < 2020:
          for k in j+1 ..< s.len:
            if s[i] + s[j] + s[k] == 2020:
              result.second = s[i] * s[j] * s[k]

let expenses = parseIntSeq "inputs/01.txt"
echo products(expenses)
