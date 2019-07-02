print "Введите имя: "
name = gets.chomp

print "Рост: "
growth = gets.to_i

print "#{name}, "
if growth - 110 < 0
  puts "ваш вес уже оптимальный"
else
  puts "ваш идеальный вес #{growth - 110}"
end