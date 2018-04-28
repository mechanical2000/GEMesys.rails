class Agilibox::MiniFormObject < SimpleDelegator
  include ActiveModel::Validations
  extend Forwardable

  def valid?
    __getobj__.valid?
    run_validations!
  end

  def invalid?
    !valid?
  end

  alias validate valid?

  def validate!
    valid? || raise_validation_error
  end

  def_delegators :__getobj__, :errors

  def save
    valid? && __getobj__.save
  end

  def save!
    validate! && __getobj__.save!
  end
end
