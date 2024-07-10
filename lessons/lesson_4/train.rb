class Train
  attr_accessor :route
	attr_reader :speed, :reverse, :number, :starting_station, :intermediate_stations, :end_station, :carriages

	@@trains = {}

	def self.find(number)
		@@trains[number]
	end

	def initialize(number) # Инцициализация поезда
		@number = number
		@speed = 0
		@reverse = 0
		@carriages = []
	end

	def up_speed(speed) # Добавить скорость
		return if speed.nil?
		if reverse > 0 
			puts "Для движения вперед, требуется отключить реверс(остановится). Текущая скорость реверса: #{@reverse} км/ч"
		else
			@speed = speed
		end
	end

	def current_speed # Текущая скорость
		puts "Текущая скорость: #{@speed} км/ч"
	end

	def braking(speed) # Тормоз
		if speed < 0
			puts "Скорость не может быть меньше 0"
		else
			@speed = speed
		end
	end

	def reverse_speed(reverse) # Включение реверcа(задний ход)
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

	def add_carriage(carriage)
		@carriages << carriage
	end

	def info_train # Информация о поезде
		puts "Информация о поезде: Номер поезда: #{@number}, Тип поезда: #{@type}"
	end

	def assign_route(route) # Назначить маршрут составу
		@route = route
		@train_route = route.split_stations
		@index = 0
		@train_route[@index].take_the_train(self)
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
			@current_station.send_a_train(self)
			@index +=1
			@current_station.take_the_train(self)
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
			@current_station.send_a_train(self)
			@index -=1
			@current_station.take_the_train(self)
			puts "Предыдущая станция: #{previous_station&.station_name}"
			puts "Tекущая_станция: #{current_station&.station_name}"
			puts "Следущая станция: #{next_station&.station_name}"
		end
	end
end