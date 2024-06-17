class Route
attr_reader :starting_station, :intermediate_stations, :end_station, :split_stations

	def initialize(starting_station, end_station) # Инцициализация маршрута
		@starting_station = starting_station
		@end_station = end_station
		@intermediate_stations = []              
	end

	def add_a_station(station_name) # Добавить промежуточную станцию
	   @intermediate_stations << station_name
	   @split_stations = [@starting_station] + @intermediate_stations + [@end_station]          
	end

	def station_delete(station_name) # Удалить станцию
		@intermediate_stations.delete(station_name)
	end

	def all_station_in_order # Посмотреть маршрут
		puts "Начальная станция: #{@starting_station.station_name}"
		puts "Промежуточные станции: #{@intermediate_stations.map(&:station_name).join(", ")}"
		puts "Конечная станция: #{@end_station.station_name}"
	end
end