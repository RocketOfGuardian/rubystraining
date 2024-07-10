require_relative 'train.rb'
require_relative 'carriage.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'cargo_carriage.rb'
require_relative 'passenger_carriage.rb'
require_relative 'station.rb'
require_relative 'route.rb'


class Main
  def main_menu
    loop do
      show_menu(MAIN_MENU, "Главное меню:")
      case gets.to_i
      when 1 then station_menu
      when 2 then train_menu
      when 3 then train_control
      when 4 then route_menu
      when 0 then exit
      else puts "Данной категории не существует, для выхода введите: 0"
      end
    end
  end

  private

  MAIN_MENU = [
    'Меню станций',
    'Меню поездов',
    'Управление поездом',
    'Меню маршрутов'
  ]

  STATION_MENU = [
    'Создать станцию',
    'Просмотр созданных станций',
    'Посмотреть поезда на станции'
  ]

  TRAIN_MENU = [
    'Создать локомотив', 
    'Прицепить вагон к локомотиву',
    'Отцепить вагон от локоматива',
    'Поставить поезд на маршрут',
    'Отправить поезд'
  ]

  TRAIN_CONTROL = [
    'Прибавить скорость',
    'Тормоз',
    'Реверс',
    'Информация о поезде'
  ]

  ROUTE_MENU = [
    'Создать маршрут',
    'Добавить промежуточную станцию',
    'Удалить промежуточную станцию',
    'Информация о маршруте'
  ]

  TRAIN_TYPE_MENU = [
    'Создать пассажирский локомотив',
    'Создать грузовой локомотив'
  ]

  DIRECTION_MENU = [
    'Следующая станция',
    'Предыдущая станция'
  ]

  CREATE_ROUTE_STATION_MENU = [
    'Добавить существующую станцию в маршрут',
    'Создать новую станцию и добавить в маршрут'
  ]

  attr_reader :trains, :routes, :stations, :carriages

  def initialize
    @trains = []
    @routes = []
    @stations = []
    @carriages = []
  end

  def station_menu
    loop do
      show_menu(STATION_MENU, "Меню станций:")
      case gets.to_i
      when 1 then create_station
      when 2 then show_array(stations)
      when 3 then trains_on_station
      when 0 then return
      else puts "Введенный элемент отсутствует в меню."
      end
    end
  end

  def train_menu
    loop do
      show_menu(TRAIN_MENU, "Меню поездов:")
      case gets.to_i
      when 1 then create_train
      when 2 then add_carriage
      when 3 then delete_carriage
      when 4 then assign_train
      when 5 then train_go
      when 0 then return
      else puts "Введенный элемент отсутствует в меню."
      end
    end
  end

  def train_control
    loop do
      show_menu(TRAIN_CONTROL, "Управление поездом:")
      case gets.to_i
      when 1 then speed
      when 2 then brake
      when 3 then reverse
      when 4 then info_tr
      when 0 then return
      else puts "Введенный элемент отсутствует в меню."
      end
    end
  end

  def route_menu
    loop do
      show_menu(ROUTE_MENU, "Меню маршрутов:")
      case gets.to_i
      when 1 then create_route
      when 2 then add_route_station
      when 3 then delete_route_station
      when 4 then show_array(routes)
      when 0 then return
      else puts "Введенный элемент отсутствует в меню."
      end
    end
  end
  

  def create_station
    puts "Введите название станции:"
    station_name = gets.chomp
    if stations.any? { |station| station.station_name == station_name }
      puts "Станция уже существует"
      return
    end
    new_station = Station.new(station_name)
    stations << new_station
    puts "Вы создали станцию: #{new_station.station_name}."
    new_station
  end

  def trains_on_station
    station = select_from_array(stations)
    return if station.nil?
    if station.trains.empty?
      puts "На станции отсутствуют поезда."
    end
    station_info(station)
    station.trains.each { |train| train_info(train)}
  end

  def create_train
    puts "Введите номер поезда:"
    number = gets.chomp
    if trains.any? { |train| train.number == number }
      puts "Поезд с таким номером уже существует."
      return
    end
    show_menu(TRAIN_TYPE_MENU, "Выберите тип поезда:")
    case gets.to_i
    when 1 then trains << PassengerTrain.new(number)
    when 2 then trains << CargoTrain.new(number)
    else
      puts "Такого действия не существует."
      return
    end
    train_info(trains.last)
  end

  def assign_train
    train = select_from_array(trains)
    return if train.nil?
    route = select_from_array(routes)
    return if route.nil?
    train.assign_route(route)
    train_info(train)
    route_info(route)
  end

  def add_carriage
    train = select_from_array(trains)
    return if train.nil?
    unless train.speed.zero?
      puts "Поезд находится в движении. Для стыковки вагона, требуется остановиться"
      return
    end
    puts "Введите номер вагона"
    carriage_number = gets.chomp

    carriage = case train
    when CargoTrain then CargoCarriage.new(carriage_number)
    when PassengerTrain then PassengerCarriage.new(carriage_number)
    end
    train.add_carriage(carriage)
    @carriages << carriage
    train_info(train)
  end

  def delete_carriage
    train = select_from_array(trains)
    return if train.nil?
    unless train.speed.zero?
      puts "Поезд находится в движении. Для расстыковки вагона, требуется остановиться"
      return
    end
    if train.carriages.size.zero?
      puts "К поезду не присоединено не одного вагона."
      return
    end
    train.delete_carriage
    train_info(train)
  end

   def train_go
    train = select_from_array(trains)
    return if train.nil?
    if train.route.nil?
      puts "У поезда отсутствует маршрут."
      return
    end
    show_menu(DIRECTION_MENU, "Выберите направление:")
    case gets.to_i
    when 1 then move_train_to_next_station(train)
    when 2 then move_train_to_previous_station(train)
    else
      puts "Такого действия не существует."
      return
    end
    train_info(train)
  end

  def speed
    train = select_from_array(trains)
    return if train.nil?
    puts "Введите скорость"
    user_speed = gets.to_i
    train.up_speed(user_speed)
  end

  def brake
    train = select_from_array(trains)
    return if train.nil?
    puts "Введите скорость"
    user_speed = gets.to_i
    train.braking(user_speed)
  end

  def reverse
    train = select_from_array(trains)
    return if train.nil?
    puts "Введите скорость"
    user_speed = gets.to_i
    train.reverse_speed(user_speed)
  end

  def info_tr
    train = select_from_array(trains)
    return if train.nil?
    train_info(train)
  end

  def move_train_to_next_station(train)
    if train.next_station.nil?
      puts "Конечная станция"
      return
    end
    train.move_forward
  end

  def move_train_to_previous_station(train)
    if train.previous_station.nil?
      puts "Конечная станция"
      return
    end
    train.move_back
  end

  def create_route
    starting_station = select_or_create_station('Начальная станция:')
    end_station = select_or_create_station('Конечная станция:')
    return if starting_station.nil? || end_station.nil?
    return if starting_station == end_station
    route = Route.new(starting_station, end_station)
    puts route.inspect
    routes << route
    route_info(route)
  end

  def add_route_station
    route = select_from_array(routes)
    return if route.nil?
    station = select_or_create_station('Станция:')
    return if station.nil?
    puts station
    if route.split_stations.include?(station)
      puts "Станция уже добавлена в маршрут."
      return
    end
    route.add_a_station(station)
    route_info(route)
  end

  def select_or_create_station(title)
    show_menu(CREATE_ROUTE_STATION_MENU, title)
    case gets.to_i
    when 1
      station = select_from_array(stations)
      return if station.nil?
      station
    when 2
      station = create_station
      if station.nil?
        puts "Станция с таким названием уже существует."
        return
      end
      station
    else
      puts "Такого действия не существует."
      return
    end
  end

  def delete_route_station
    route = select_from_array(routes)
    return if route.nil?
    station = select_from_array(route.stations)
    return if station.nil?
    if [route.first_station, route.end_station].include?(station)
      puts "Удаление начальной и конечной станций, запрещено."
      return
    end
    route.delete_station(station)
    route_info(route)
  end

  def show_menu(menu, title = nil)
    puts title if title
    menu.each.with_index(1) do |item, index|
      puts "#{index}. #{item}"
    end
    puts "0. Выход"
  end

  # Формирует список чего-нибудь с индексами
  def show_array(array)
    return puts "Поезд, станция или маршрут не созданы." if array.empty?
    puts "Созданные объекты:"
    array.each.with_index(1) do |item, index|
      print "#{index}. "
      info(item)
    end
  end

  # Выбор элемента из списка | возвращает этот элемент
  def select_from_array(array)
    return if show_array(array).nil?
    puts "Введите -> (1 - #{array.size})"
    index = gets.to_i
    if index.between?(1, array.size)
      array[index - 1]
    else
      puts "Такого действия не существует."
      return
    end
  end

#Info methods
  def info(item)
    case item
    when Station then station_info(item)
    when Train then train_info(item)
    when Route then route_info(item)
    end
  end

  def train_info(train)
    "Метод info перенести в метод объекта класса и назвать его to_s"
    puts "Поезд -> Номер: #{train.number}; Тип: #{train.type} поезд; Количество вагонов: #{train.carriages}; Скорость: #{train.speed} км/ч; Скорость реверса: #{train.reverse} км/ч"
    unless train.route.nil?
      if train.previous_station.nil?
        previous_station = "N/D"
      else
        previous_station = train.previous_station.station_name
      end
      current_station = train.current_station.station_name
      if train.next_station.nil?
        next_station = "N/D"
      else
        next_station = train.next_station.station_name
      end
      puts "Предыдущая станция: #{previous_station}; Текущая станция: #{current_station}; Следующая станция: #{next_station};"
    end
  end

  def route_info(route)
    print "Маршрут "
    route.split_stations.each { |station| print "->#{station.station_name}" }
    puts
  end

  def station_info(station)
    puts "Станция: #{station.station_name}"
  end
end

main = Main.new
main.main_menu