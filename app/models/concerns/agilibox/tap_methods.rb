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
end
