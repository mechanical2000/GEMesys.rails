class Agilibox::FCM::Notifier < Agilibox::Service
  attr_reader :to, :title, :body, :badge, :sound, :data

  # rubocop:disable Metrics/ParameterLists
  def initialize(to:, title: nil, body:, badge: 0, sound: "default", data: {})
    @to    = to
    @title = title
    @body  = body
    @badge = badge
    @sound = sound
    @data  = data
  end
  # rubocop:enable Metrics/ParameterLists

  def call
    Agilibox::FCM::Request.call(
      :to => to,
      :notification => {
        :title => title,
        :body  => body,
        :badge => badge,
        :sound => sound,
      },
      :data => data,
    )
  end
end
