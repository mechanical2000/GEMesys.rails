class Agilibox::SMS::Strategies::Test < Agilibox::SMS::Strategies::Base
  def self.deliveries
    @deliveries ||= []
  end

  private

  def call
    self.class.deliveries << data
    Rails.logger.info "New SMS sent : #{data.inspect}"
  end
end
