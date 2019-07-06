
fibo = [1, 1]

prev, curr = fibo.first, fibo.last

while fibo.last < 100 do
  next_val = fibo[-1] + fibo[-2]

  break if next_val > 100

  fibo << next_val

end

print fibo
