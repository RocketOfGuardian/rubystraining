class Carriage
	attr_reader :number, :type

	def initialize(number)
		@number = number
    init_type
	end

  def cargo?
    @type == "Грузовой"
  end

  def passenger?
    @type == "Пассажирский"
  end
end