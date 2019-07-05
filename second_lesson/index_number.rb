def is_leap(year)
  return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
end

puts "year: "
year = gets.chomp.to_i

puts "month[1-12]: "
month = gets.chomp.to_i

puts "day: "
days = gets.chomp.to_i

months = {1 => 31, 2 => 28, 3 => 31,
          4 => 30, 5 => 31, 6 => 30,
          7 => 31, 8 => 31, 9 => 30,
          10 => 31, 11 => 30, 12 => 31}

index_number = is_leap(year) ? 1 : 0
i = 1
puts index_number

while i < month
  index_number += months[i]
  i += 1
end

index_number += days

puts index_number
