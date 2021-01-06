from functools import reduce
from operator import mul


timestamp, buses = (int((f := open("inputs/13.txt")).readline().strip()),
                    [(i, int(bus)) for i, bus in enumerate(f.readline().strip().split(',')) if bus != 'x'])

crt = (lambda prev, curr:
          (lambda res, prime, i, bus:
              next((n, prime*bus) for n in range(res, prime*bus, prime)
                                  if not (n+i) % bus))
          (*prev, *curr))


print(mul(*(reduce(min, ((-timestamp % bus, bus) for _, bus in buses)))))
print(reduce(crt, buses, (0, 1))[0])
