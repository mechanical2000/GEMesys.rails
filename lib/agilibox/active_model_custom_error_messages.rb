module Agilibox::ActiveModelCustomErrorMessages
  def full_message(attribute, message)
    return message[1..-1] if message[0] == "^"
    super(attribute, message)
  end
end

ActiveModel::Errors.send(:prepend, Agilibox::ActiveModelCustomErrorMessages)
