if Rails.env.production?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.raise_delivery_errors = true

  ActionMailer::Base.smtp_settings = {
    :user_name      => ENV['SENDGRID_SMTP_LOGIN'],
    :password       => ENV['SENDGRID_SMTP_PASSWORD'],
    :domain         => 'supermanager.thomasbrus.nl',
    :port           => 587,
    :address        => 'smtp.sendgrid.net',
    :authentication => :plain,
    :enable_starttls_auto => true
  }
end
