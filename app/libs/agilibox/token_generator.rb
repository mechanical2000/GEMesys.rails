class Agilibox::TokenGenerator
  attr_reader :options

  def initialize(options = {})
    @options = options
  end

  def size
    options[:size] || self.class.default_size
  end

  def alphabet
    options[:alphabet] || self.class.default_alphabet
  end

  def call
    (alphabet * size).sample(size).join
  end

  class << self
    def call(*args)
      new(*args).call
    end

    attr_writer :default_size

    def default_size
      @default_size ||= 64
    end

    attr_writer :default_alphabet

    def default_alphabet
      @default_alphabet ||= (0..9).to_a + ("a".."z").to_a + ("A".."Z").to_a
    end
  end # class << self
end
