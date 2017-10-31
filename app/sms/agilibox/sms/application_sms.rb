class Agilibox::SMS::ApplicationSMS
  attr_reader :options

  def initialize(options)
    @options = options
  end

  private

  def action_name
    options[:action_name]
  end

  def t(key, *args)
    if key.start_with?(".")
      path = self.class.to_s.underscore.tr("/", ".")
      key  = "#{path}.#{action_name}#{key}"
    end

    I18n.t(key, *args)
  end

  def sms(data)
    Agilibox::SMS.strategy.new(data)
  end

  class << self
    private :new

    def method_missing(m, *args)
      if respond_to_missing?(m)
        new(action_name: m).public_send(m, *args)
      else
        super
      end
    end

    def respond_to_missing?(m, *)
      public_instance_methods.include?(m)
    end
  end # class << self
end
