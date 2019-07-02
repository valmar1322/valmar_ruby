print "Введите имя: "
name = gets.chomp

print "Рост: "
growth = gets.to_i

perfect_weight = growth - 110

print "#{name}, "

if perfect_weight < 0
  puts "ваш вес уже оптимальный"
else
  puts "ваш идеальный вес #{perfect_weight}"
end
