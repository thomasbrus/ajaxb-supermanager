class AdminMailer < ActionMailer::Base
  layout false
  default from: "Ajax-B Supermanager <ajaxb.supermanager@gmail.com>"

  def contact(message)
    subject = "Bericht van #{message.email} via de Supermanager"
    receipents = {
      1 => "Thomas Brus <thomas.brus@me.com>",
      2 => "N.Huntink <nhuntink@planet.nl>"
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