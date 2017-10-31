class Agilibox::SMS::Strategies::Base
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def deliver_now
    call
  end

  # TODO : Delay
  def deliver_later
    deliver_now
  end

  private

  def call
    raise NotImplementedError
  end
end
