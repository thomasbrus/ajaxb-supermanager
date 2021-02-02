ActionMailer::Base.smtp_settings = {
  :user_name => ENV['SENDGRID_SMTP_USERNAME'],
  :password => ENV['SENDGRID_SMTP_PASSWORD'],
  :domain => 'supermanager.thomasbrus.nl',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :login,
  :enable_starttls_auto => true
}
