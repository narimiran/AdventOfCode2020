import re


pattern = re.compile(r"(\d+)-(\d+) (\w): (\w+)")

def parse_line(line):
    lo, hi, c, pw  = re.match(pattern, line).groups()
    return int(lo), int(hi), c, pw

is_valid_1 = lambda lo, hi, c, pw: lo <= pw.count(c) <= hi
is_valid_2 = lambda lo, hi, c, pw: (pw[lo-1] == c) ^ (pw[hi-1] == c)


content = [parse_line(line) for line in open("inputs/02.txt").readlines()]

print(sum(is_valid_1(*line) for line in content))
print(sum(is_valid_2(*line) for line in content))
