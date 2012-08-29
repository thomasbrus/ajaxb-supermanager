if Rails.env.production?
  ActionMailer::Base.default_url_options = { :host => 'supermanager.herokuapp.com' }
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.raise_delivery_errors = false
  ActionMailer::Base.default :charset => "utf-8"

  ActionMailer::Base.smtp_settings = {
    address:              'smtp.gmail.com',
    port:                 587,
    authentication:       :plain,
    enable_starttls_auto: true,
    user_name:            ENV['GMAIL_USERNAME'],
    password:             ENV['GMAIL_PASSWORD'],
  }
end