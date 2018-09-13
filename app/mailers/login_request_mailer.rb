class LoginRequestMailer < ActionMailer::Base
  layout 'email'
  default from: "ajaxb.supermanager@gmail.com"

  def login_link(contestant, login_request)
    @contestant, @validation_key = contestant, login_request.validation_key
    mail(to: contestant.email, subject: "Bevestigingslink inloggen bij de Supermanager")
  end

end
