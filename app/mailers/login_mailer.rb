class ContestantMailer < ActionMailer::Base
  default from: "Ajax-B Supermanager ajaxb.supermanager@gmail.com"
 
  def login_key(contestant)
    mail(to: contestant.email, subject: "Lorem Ipsum")
  end
end
