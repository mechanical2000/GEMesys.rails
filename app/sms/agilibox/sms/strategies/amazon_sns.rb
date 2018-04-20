class Agilibox::SMS::Strategies::AmazonSNS < Agilibox::SMS::Strategies::Base
  class << self
    attr_writer :sns_region

    def sns_region
      @sns_region ||= (ENV["SNS_REGION"] || ENV["AWS_REGION"])
    end

    attr_writer :sns_access_key_id

    def sns_access_key_id
      @sns_access_key_id ||= (ENV["SNS_ACCESS_KEY_ID"] || ENV["AWS_ACCESS_KEY_ID"])
    end

    attr_writer :sns_secret_access_key

    def sns_secret_access_key
      @sns_secret_access_key ||= (ENV["SNS_SECRET_ACCESS_KEY"] || ENV["AWS_SECRET_ACCESS_KEY"])
    end
  end # class << self

  def client
    @client ||= Aws::SNS::Client.new(
      :region            => self.class.sns_region,
      :access_key_id     => self.class.sns_access_key_id,
      :secret_access_key => self.class.sns_secret_access_key,
    )
  end

  private

  def call
    from = data[:from] || Agilibox::SMS.default_from

    client.publish(
      :phone_number       => data[:to],
      :message            => data[:body],
      :message_attributes => {
        "AWS.SNS.SMS.SenderID" => {
          :data_type    => "String",
          :string_value => from,
        },
        "AWS.SNS.SMS.SMSType"  => {
          :data_type    => "String",
          :string_value => "Transactional",
        },
      },
    )
  end
end
