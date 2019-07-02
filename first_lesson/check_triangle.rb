puts "Программа определяющая вид треугольника"

print "Введите длину a: "
a = gets.to_i

print "Введите длину b: "
b = gets.to_i

print "Введите длину c: "
c = gets.to_i

if a == b && a == c && b == c
  puts "Треугольник равнобедренный и равносторонний"
elsif a == b || a == c || b == c
  puts "Треугольник равнобедренный"
end

a, b, hypo = [a, b, c].sort!

if hypo**2 == a**2 + b**2
  puts "Треугольник прямоугольный"
end
