class ContestantMailer < ActionMailer::Base
  layout 'email'
  default from: "Ajax-B Supermanager <ajaxb.supermanager@gmail.com>"

  def welcome(contestant, login_request)
    @contestant, @validation_key = contestant, login_request.validation_key
    mail(to: contestant.email, subject: "Welkom bij de Supermanager!")      
  end

  def reminder(contestant, login_request)
    @contestant, @validation_key = contestant, login_request.validation_key
    mail(to: contestant.email, subject: "Herinnering invullen superteam")
  end
end
