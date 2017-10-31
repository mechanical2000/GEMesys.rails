module Agilibox::SMS
  class << self
    attr_writer :strategy

    def strategy
      @strategy ||= default_strategy
    end

    attr_writer :default_from

    def default_from
      @default_from ||= Rails.application.class.to_s.chomp("::Application")
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
