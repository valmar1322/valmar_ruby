def leap_year?(year)
  return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
end

puts "year: "
year = gets.to_i

puts "month[1-12]: "
month = gets.to_i

puts "day: "
days = gets.to_i

months = [
  31, 28, 31,
  30, 31, 30,
  31, 31, 30,
  31, 30, 31
]

index_number = 0

if month > 2
  index_number = leap_year?(year) ? 1 : 0
end

index_number += months.take(month - 1).sum + days

puts index_number
