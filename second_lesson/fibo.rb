
fibo = [1, 1]

prev, curr = 1, 1

while fibo.last < 100 do
  next_val = prev + curr

  if next_val > 100
    break
  end

  fibo << next_val
  prev = curr
  curr = next_val
end

print fibo
