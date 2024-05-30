puts "Введите первое число"
a = gets.to_i
puts "Введите второе число"
b = gets.to_i
puts "Введите третье число"
c = gets.to_i

d = (b**2 - 4*a*c)

if d > 0
	x1 = (-b + Math.sqrt(d))/(2*a)
	x2 = (-b - Math.sqrt(d))/(2*a)
	puts "Дискриминант: #{d}, Первый корень: #{x1}, Второй корень: #{x2}"
elsif d == 0
	puts "Дискриминант: #{d}, Корень: #{x1}"
elsif d < 0
	puts "Дискриминант: #{d}, Корней нет"
end

		