class Train
	attr_accessor :number_of_wagons, :route
	attr_reader :speed, :reverse, :number, :type, :starting_station, :intermediate_stations, :end_station

	def initialize(number, type, number_of_wagons) # Инцициализация поезда
		@number = number
		types = { 1 => 'Пассажирский', 2 => 'Грузовой' }
		if type.to_i > 2 || type.to_i < 1
			puts "Такого типа поезда не существует, используйте 1 или 2"
			puts "1 - Пассажирский"
			puts "2 - Грузовой"
		return nil unless number && type && number_of_wagons
		else
			@type = types[type]
		end
		@number_of_wagons = number_of_wagons
		@speed = 0
		@reverse = 0
	end

	def up_speed=(speed) # Добавить скорость
		if reverse > 0 
			puts "Для движения вперед, требуется отключить реверс(остановится). Текущая скорость реверса: #{@reverse} км/ч"
		else
			@speed = speed
		end
	end

	def current_speed # Текущая скорость
		puts "Текущая скорость: #{@speed} км/ч"
	end

	def braking=(speed) # Тормоз
		if speed < 0
			puts "Скорость не может быть меньше 0"
		else
			@speed = speed
		end
	end

	def reverse_speed=(reverse) # Включение реверcа(задний ход)
		if speed > 0
			puts "Для включения реверса, остановите поезд. Текущая скорость: #{@speed} км/ч"
		else
			@reverse = reverse
		end
	end

	def current_reverse_speed # Текущая скорость реверса
		puts "Скорость реверса: #{@reverse} км/ч"
	end

	def braking_reverse_speed=(reverse) # Тормоз реверса
		if reverse < 0
			puts "Скорость реверса не может быть меньше 0"
		else
			@reverse = reverse
		end
	end

	def wagons # Количетсво вагонов подцепленных к локомотиву
		puts "Количество вагонов: #{@number_of_wagons}"
	end

	def add_wagons # Прицепить вагон
		if speed > 0 || reverse > 0
			puts "Для сцепки вагона, требуется остановить поезд. На данный момент текущая скорость: #{@speed} км/ч; Реверс: #{@reverse} км/ч"
		else
			@number_of_wagons += 1
			puts "К локомотиву присоединён вагон"
		end
	end

	def remove_wagons # Отцепить вагон
		if number_of_wagons < 0 || number_of_wagons == 0
			puts "Количетсво вагонов не может быть меньше 0"
		elsif speed > 0 || reverse > 0
			puts "Для расстыковки вагона, требуется остановить поезд. На данный момент текущая скорость: #{@speed} км/ч; Реверс: #{@reverse} км/ч" 
		else
			@number_of_wagons -= 1
			puts "От локомотива отцепили вагон"
		end
	end

	def info_train # Информация о поезде
		puts "Информация о поезде: Номер поезда: #{@number}, Тип поезда: #{@type}, Количество подцепленных вагонов: #{@number_of_wagons}"
	end

	def assign_route(route) # Назначить маршрут составу
		@train_route = route.split_stations
		@index = 0
	end

	def current_station # Текущая станция
		@current_station = @train_route[@index]
	end

	def next_station # Следующая станция
		@train_route[@index + 1]
	end

	def previous_station # Предыдущая станция
		@train_route[@index - 1]
	end

	def move_forward # Ехать вперёд по маршруту
		if reverse > 0
			puts "Для движения по маршруту вперед, отключите реверс(остановитесь)"
		elsif speed == 0
			puts "Для начала маршрута, требуется добавить скорость"
		else
			@index +=1
			puts "Предыдущая станция: #{previous_station&.station_name}"
			puts "Tекущая_станция: #{current_station&.station_name}"
			puts "Следущая станция: #{next_station&.station_name}"
		end
	end

	def move_back # Ехать назад по маршруту
		if speed > 0
			puts "Для движения по маршруту назад, требуется остановиться и включить реверс"
		elsif reverse == 0
			puts "Для возврата на предыдущую станцию, требуется включить реверс"
		else
			@index -=1
			puts "Предыдущая станция: #{previous_station&.station_name}"
			puts "Tекущая_станция: #{current_station&.station_name}"
			puts "Следущая станция: #{next_station&.station_name}"
		end
	end
end