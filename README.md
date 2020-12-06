# Advent of Code 2020

All my Advent of Code repos:

* [AoC 2015 in Nim](https://github.com/narimiran/advent_of_code_2015)
* [AoC 2016 in Python](https://github.com/narimiran/advent_of_code_2016)
* [AoC 2017 in Nim, OCaml, Python](https://github.com/narimiran/AdventOfCode2017)
* [AoC 2018 in Nim](https://github.com/narimiran/AdventOfCode2018)
* [AoC 2019 in OCaml](https://github.com/narimiran/AdventOfCode2019)
* [AoC 2020 in Nim](https://github.com/narimiran/AdventOfCode2020) (this repo)


&nbsp;


## Solutions



Task                                                              | Solution                   | Comment
---                                                               | ---                        | ---
[Day 1: Report Repair](https://adventofcode.com/2020/day/1)       | [day01.nim](nim/day01.nim) | Small check `elif s[i] + s[j] < 2020:` makes the whole program ~4x faster.
[Day 2: Password Philosophy](https://adventofcode.com/2020/day/2) | [day02.nim](nim/day02.nim) | `scanf` useful as always.
[Day 3: Toboggan Trajectory](https://adventofcode.com/2020/day/3) | [day03.nim](nim/day03.nim) | Keeping it below 20 lines :)
[Day 4: Passport Processing](https://adventofcode.com/2020/day/4) | [day04.nim](nim/day04.nim) | Had a nasty early morning bug with `if not v.len == 9`. Argh.
[Day 5: Binary Boarding](https://adventofcode.com/2020/day/5)     | [day05.nim](nim/day05.nim) | Traversing a sorted list is more eficient than looking for every number in unsorted one.
[Day 6: Custom Customs](https://adventofcode.com/2020/day/6)      | [day06.nim](nim/day06.nim) | Classic AoC-use-sets tasks.

