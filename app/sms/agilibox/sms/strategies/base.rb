class Agilibox::SMS::Strategies::Base
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def call
    raise NotImplementedError
  end

  def self.call(*args)
    new(*args).call
  end
end
