numbers = []

from = 10
to   = 100
diff = 5

from.step(by: diff, to: to) { |value| numbers << value }

print numbers
