class CargoTrain < Train
  attr_reader :type
  def type
    @type = "Грузовой"
  end

  def up_speed(speed)
    super
  end

  def braking(speed)
    super
  end

  def reverse_speed(reverse)
    super
  end
  
  def add_carriage(carriage)
    super if carriage.cargo?
  end
end