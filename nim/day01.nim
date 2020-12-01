import strutils, sequtils


let expenses = toSeq("./inputs/01.txt".lines).map(parseInt)

func products(s: seq[int]): (int, int) =
  for i in 0 ..< s.len:
      for j in i+1 ..< s.len:
        if s[i] + s[j] == 2020:
          result[0] = s[i] * s[j]
        elif s[i] + s[j] < 2020:
          for k in j+1 ..< s.len:
            if s[i] + s[j] + s[k] == 2020:
              result[1] = s[i] * s[j] * s[k]


echo products(expenses)
