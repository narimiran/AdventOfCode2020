import strutils

func isValid1(passport: string): bool =
  for r in ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]:
    if r notin passport: return false
  return true

func isValid2(passport: string): bool =
  for field in passport.splitWhitespace:
    let v = field[4..field.high] # ':' is always at index 3
    case field[0..2]
    of "byr":
      if parseInt(v) notin 1920..2002: return false
    of "iyr":
      if parseInt(v) notin 2010..2020: return false
    of "eyr":
      if parseInt(v) notin 2020..2030: return false
    of "hgt":
      case v[^2..^1]
      of "cm":
        if parseInt(v[0..^3]) notin 150..193: return false
      of "in":
        if parseInt(v[0..^3]) notin 59..76: return false
      else: return false
    of "hcl":
      if not (v.startsWith('#') and v.len == 7): return false
      for h in v[1..6]:
        if h notin {'0'..'9', 'a'..'f'}: return false
    of "ecl":
      if v notin ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]: return false
    of "pid":
      if v.len != 9: return false
      for l in v:
        if l notin {'0'..'9'}: return false
  return true

proc solve(path: string): (int, int) =
  let passports = readFile path
  for passport in passports.split("\n\n"):
    if passport.isValid1:
      inc result[0]
      if passport.isValid2:
        inc result[1]

echo solve "inputs/04.txt"
