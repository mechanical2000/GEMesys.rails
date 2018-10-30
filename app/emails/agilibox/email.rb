class Agilibox::Email
  include ActiveModel::Model
  include Agilibox::ModelToS
  include Agilibox::ModelI18n

  validates :to,      presence: true
  validates :subject, presence: true
  validates :body,    presence: true

  validate :validate_addr_formats

  attr_accessor(
    :current_user,
    :from,
    :reply_to,
    :to,
    :cc,
    :subject,
    :body,
    :attachments,
  )

  def initialize(*)
    super
    assign_default_values
  end

  def attachment_names
    attachments.keys.join(", ")
  end

  def validate_and_deliver
    ok = valid?
    deliver if ok
    ok
  end

  def data
    {
      :from        => from,
      :reply_to    => reply_to,
      :to          => to,
      :cc          => cc,
      :subject     => subject,
      :body        => body,
      :attachments => attachments,
    }
  end

  def deliver
    deliver_now
  end

  def deliver_now
    Agilibox::GenericMailer.generic_email(data).deliver_now
  end

  def deliver_later
    Agilibox::GenericMailer.generic_email(data).deliver_later
  end

  private

  def assign_default_values
    self.from        ||= default_from
    self.reply_to    ||= default_reply_to
    self.to          ||= default_to
    self.cc          ||= default_cc
    self.subject     ||= default_subject
    self.body        ||= default_body
    self.attachments ||= default_attachments
  end

  def default_from
  end

  def default_reply_to
    "#{current_user} <#{current_user.email}>" if current_user
  end

  def default_to
  end

  def default_cc
  end

  def default_subject
  end

  def default_body
  end

  def default_attachments
    {}
  end

  def validate_addr_formats
    validate_addr_formats_for(:from)
    validate_addr_formats_for(:reply_to)
    validate_addr_formats_for(:to)
    validate_addr_formats_for(:cc)
  end

  def validate_addr_formats_for(attr)
    require "mail"

    string = public_send(attr).to_s
    return if string.blank?
    addrs  = Mail.new(to: string).to_addrs
    return true if addrs.any? && addrs.all? { |addr| URI::MailTo::EMAIL_REGEXP.match?(addr) }
    errors.add(attr, :invalid)
  end
end
