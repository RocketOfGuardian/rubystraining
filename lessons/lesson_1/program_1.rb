puts "Как вас зовут?"
last_name = gets.chomp
puts "Введите свой рост:"
height = gets.chomp
weight_calculation = (height.to_i - 110) * 1.15
if weight_calculation > 0
	puts "#{last_name}, ваш оптимальный вес #{weight_calculation.to_i}" # Для переменной weight_calculation в выводе добавлен to_i чтобы не выводилось дробное значение
else
	puts "#{last_name}, ваш вес уже оптимальный"
end