class Agilibox::SMS::Message
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def strategy=(value)
    @strategy = Agilibox::SMS.parse_strategy(value)
  end

  def strategy(value = :no_argument)
    self.strategy = value unless value == :no_argument
    @strategy || Agilibox::SMS.strategy
  end

  def deliver_now
    strategy.call(data)
  end

  # TODO : Delay
  def deliver_later
    deliver_now
  end
end
