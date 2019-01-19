module Agilibox::ModelI18n
  extend ActiveSupport::Concern

  MissingTranslationError = Class.new(StandardError)
  class << self
    attr_accessor :raise_on_missing_translations
  end
  self.raise_on_missing_translations = false

  def t(*args)
    self.class.t(*args)
  end

  def ts
    self.class.ts
  end

  def tv(attribute)
    value = public_send(attribute)
    t("#{attribute}.#{value}") if value.present?
  end

  class_methods do
    def t(attribute = nil, options = {})
      should_raise = Agilibox::ModelI18n.raise_on_missing_translations
      exception_class = Agilibox::ModelI18n::MissingTranslationError

      if should_raise
        options = options.merge(default: "")
      end

      if should_raise && attribute.nil?
        human = model_name.human(options)
        type = options[:count].to_i > 1 ? "plural" : "singular"
        raise exception_class, "translation missing: #{self} #{type} model name" if human.blank?
        return human
      end

      if should_raise && attribute
        human = human_attribute_name(attribute, options)
        raise exception_class, "translation missing: #{self}##{attribute}" if human.blank?
        return human
      end

      if attribute.nil?
        return model_name.human(options)
      end

      human_attribute_name(attribute, options) if attribute
    end

    def ts
      t(nil, count: 2)
    end
  end # class_methods
end # Agilibox::ModelI18n
