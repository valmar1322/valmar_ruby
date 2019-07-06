
fibo = [1, 1]

loop do
  next_val = fibo[-1] + fibo[-2]
  break if next_val > 100
  fibo << next_val
end

print fibo
