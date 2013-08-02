if Rails.env.production?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.default_charset = "utf-8"
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.raise_delivery_errors = true
  ActionMailer::Base.smtp_settings = {
    :port           => ENV['MAILGUN_SMTP_PORT'], 
    :address        => ENV['MAILGUN_SMTP_SERVER'],
    :user_name      => ENV['MAILGUN_SMTP_LOGIN'],
    :password       => ENV['MAILGUN_SMTP_PASSWORD'],
    :domain         => 'supermanager.mailgun.org',
    :authentication => :plain,
  }
end