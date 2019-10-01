module Agilibox::TapMethods
  extend ActiveSupport::Concern

  def tap_save!(options = {})
    save!(options)
    self
  end

  def tap_update!(attributes)
    update!(attributes)
    self
  end

  def tap_validate(context = nil)
    validate(context)
    self
  end

  def tap_validate!(context = nil)
    validate!(context)
    self
  end

  def tap_update_columns(attributes)
    update_columns(attributes) # rubocop:disable Rails/SkipsModelValidations
    self
  end

  def tap_update_column(name, value)
    update_column(name, value) # rubocop:disable Rails/SkipsModelValidations
    self
  end
end
