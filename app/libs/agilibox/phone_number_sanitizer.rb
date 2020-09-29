class Agilibox::PhoneNumberSanitizer
  attr_reader :phone_number

  def initialize(phone_number)
    @phone_number = phone_number
  end

  def call
    phone_number.to_s.gsub(/[^0-9+]+/, "").presence
  end

  def self.call(*args)
    new(*args).call
  end
end
