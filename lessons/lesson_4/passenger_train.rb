class PassengerTrain < Train
  attr_reader :type
  def type
    @type = "Пассажирский"
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
    super if carriage.passenger?
  end
end