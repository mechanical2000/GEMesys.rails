class Agilibox::GenericMailer < Agilibox::ApplicationMailer
  def generic_email(data)
    data.delete(:attachments).to_h.each do |filename, content|
      attachments[filename] = content
    end

    mail(data)
  end
end
