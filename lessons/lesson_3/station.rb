class Station
	attr_reader :station_name, :trains

	def initialize(station_name) # Инциализация станции
		@station_name = station_name
		@trains = []
	end

	def take_the_train(train) # Добавить поезд на станцию
		@trains << train
		puts "На станцию #{station_name} прибыл #{train.type} поезд #{train.number}"
	end

	def list_of_trains # Вывод списка поездов
		@trains.each do |train|
		puts "Номер: #{train.number}"
		puts "Тип: #{train.type}"
		end
		puts "Количесто поездов на станции: #{@trains.size}"
	end

	def list_of_trains_types # Вывод количества поездов по типу
		puts "Пассажирских: #{@trains.count { |train| train.type == "Пассажирский" }}"
		puts "Грузовых: #{@trains.count { |train| train.type == "Грузовой" }}"
	end

	def send_a_train(train) # Отправить поезд со станции
		if @trains.include?(train)
			@trains.delete(train)
			puts "#{train.type} поезд, номер #{train.number} отправился со станции #{station_name}"
		else
			puts "На станции #{@station_name} отсутствуют поезда"
		end
	end
end

