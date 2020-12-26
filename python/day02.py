import re


pattern = re.compile(r"(\d+)-(\d+) (\w): (\w+)")

def parse_line(line):
    lo, hi, c, pw  = re.match(pattern, line).groups()
    return int(lo), int(hi), c, pw

is_valid = (lambda part, lo, hi, c, pw:
            lo <= pw.count(c) <= hi if part == 1 else
            (pw[lo-1] == c) ^ (pw[hi-1] == c))

content = [parse_line(line) for line in open("inputs/02.txt").readlines()]

print([sum(is_valid(p, *line) for line in content) for p in (1, 2)])
