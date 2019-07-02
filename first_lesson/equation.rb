puts "Программа решающая квадратное уравнение"

print "a: "
a = gets.to_f

print "b: "
b = gets.to_f

print "c: "
c = gets.to_f

d = b**2 - 4 * a * c

if d < 0
  puts "Корней нет D = #{d}"
elsif d == 0
  x = -b / (2.0 * a)
  print "Дискриминант D = #{d}\nУравнение имеет один корень: x1 = #{x}"
else 
  sqrt = Math.sqrt(d)
  x1 = (-b + sqrt) / (2.0 * a)
  x2 = (-b - sqrt) / (2.0 * a)
  print "Дискриминант [D] = #{d}\nУравнение имеет два корня: x1 = #{x1} | x2 = #{x2}"
end
