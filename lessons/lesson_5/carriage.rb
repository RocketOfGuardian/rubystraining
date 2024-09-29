require_relative 'company_name.rb'
class Carriage
  include CompanyName
	attr_reader :number, :type

	def initialize(number, company_name)
		@number = number
    @company_name = company_name
    init_type
	end

  def cargo?
    @type == "Грузовой"
  end

  def passenger?
    @type == "Пассажирский"
  end
end