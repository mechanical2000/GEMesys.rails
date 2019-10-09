module Agilibox::SMS
  class << self
    def strategy=(value)
      @strategy = parse_strategy(value)
    end

    def strategy
      @strategy ||= default_strategy
    end

    attr_writer :default_from

    def default_from
      @default_from ||= Rails.application.class.to_s.chomp("::Application")
    end

    def parse_strategy(value)
      if value.is_a?(Symbol)
        "Agilibox::SMS::Strategies::#{value.to_s.camelcase}".constantize
      else
        value
      end
    end

    private

    def default_strategy
      if Rails.env.development? || Rails.env.test?
        Agilibox::SMS::Strategies::Test
      else
        Agilibox::SMS::Strategies::AmazonSNS
      end
    end
  end # class << self
end
