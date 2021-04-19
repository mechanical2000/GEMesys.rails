module Agilibox::ActiveModelCustomErrorMessages
  # Rails <= 6.0
  module ForErrors
    def full_message(attribute, message)
      return message[1..] if message[0] == "^"
      super
    end
  end

  ActiveModel::Errors.prepend(ForErrors)

  # Rails >= 6.1
  module ForError
    def full_message
      return message[1..] if message[0] == "^"
      super
    end
  end

  if Module.const_defined?("ActiveModel::Error")
    ActiveModel::Error.prepend(ForError)
  end
end
