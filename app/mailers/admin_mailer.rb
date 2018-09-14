class AdminMailer < ActionMailer::Base
  layout false
  default from: "info@thomasbrus.nl"

  def contact(message)
    subject = "Bericht van #{message.email} via de Supermanager"
    receipents = {
      1 => "thomas.brus@me.com",
      2 => "nhuntink@planet.nl"
    }
    @content = message.content
    mail(
      to: (receipents[message.receipent.to_i] || receipents[1]),
      subject: subject,
      cc: message.email,
      reply_to: message.email
    )
  end

end
