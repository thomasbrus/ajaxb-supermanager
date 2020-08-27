class AdminMailer < ActionMailer::Base
  layout false
  default from: "info@thomasbrus.nl"

  def contact(message)
    subject = "Bericht van #{message.email} via de Supermanager"
    recipients = {
      1 => "thomas.brus@me.com",
      2 => "nhuntink@caiway.com"
    }
    @content = message.content
    mail(
      to: (recipients[message.recipient.to_i] || recipients[1]),
      subject: subject,
      cc: message.email,
      reply_to: message.email
    )
  end

end
