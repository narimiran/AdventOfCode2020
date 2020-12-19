import re


rules = {
    'byr': lambda v: 1920 <= int(v) <= 2002,
    'iyr': lambda v: 2010 <= int(v) <= 2020,
    'eyr': lambda v: 2020 <= int(v) <= 2030,
    'hgt': lambda v: (
        150 <= int(v[:-2]) <= 193 if v[-2:] == "cm" else
         59 <= int(v[:-2]) <= 76  if v[-2:] == "in" else False),
    'hcl': lambda v:  bool(re.match(r"^#[0-9a-f]{6}$", v)),
    'ecl': lambda v: v in {"amb", "blu", "brn", "gry", "grn", "hzl", "oth"},
    'pid': lambda v: bool(re.match(r"^\d{9}$", v))
}

all_passports = (dict(field.split(':') for field in passport.split()
                                       if not field.startswith("cid"))
                 for passport in open('inputs/04.txt').read().split('\n\n'))

valid = [p for p in all_passports if p.keys() == rules.keys()]

print(len(valid))
print(sum(all(rules[k](v) for k, v in p.items()) for p in valid))
