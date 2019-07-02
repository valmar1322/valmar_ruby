puts "Программа решающая квадратное уравнение"

print "a: "
a = gets.to_i

print "b: "
b = gets.to_i

print "c: "
c = gets.to_i

D = b**2 - 4 * a * c

if D < 0
  puts "Корней нет D = #{D}"
elsif D == 0
  print "Дискриминант D = #{D}\nУравнение имеет один корень: x1 = #{-b / (2.0 * a)}"
else 
  x1 = (-b + Math.sqrt(D)) / (2 * a)
  x2 = (-b - Math.sqrt(D)) / (2 * a)
  print "Дискриминант [D] = #{D}\nУравнение имеет два корня: x1 = #{x1} | x2 = #{x2}"
end
