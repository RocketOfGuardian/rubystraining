puts "Корзина покупок"
puts "Добавляйте товары в корзину поочерёдно, записывая наименование товара, цену за единицу и количество"
puts "Для окончания расчета, введите в наименовании товара 'стоп'"
basket = {}
result = 0
loop do
	puts "Введите наименование товара"
	product_name = gets.chomp
	break if product_name == "стоп"
	if basket[product_name].nil?
		puts "Введите цена за единицу"
		price_per_unit = gets.chomp.to_f
		basket[product_name] = price_per_unit
		puts "Введите количество товара"
		quantity = gets.chomp.to_f
		basket[product_name] = { price_per_unit => quantity }
	else 
		puts "Данный товар уже присутствует в корзине"
	end
end
basket.each do |name, price|
	puts "Куплено товара #{name} на сумму #{price.keys.first * price.values.first}"
	result += price.keys.first * price.values.first
end

puts "Итоговая сумма: #{result}"
