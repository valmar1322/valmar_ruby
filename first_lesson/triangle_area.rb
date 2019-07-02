puts "Программа вычисляющая площадь треугольника"

print "Высота [h]: "
height = gets.to_i

print "Основание [a]: "
base = gets.to_i

area = 0.5 * height * base
puts "Площадь треугольника: #{area} кв. ед."
