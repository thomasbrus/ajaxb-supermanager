Supermanager::Application.configure do
  if ENV['SECRET_TOKEN'].present?
    config.secret_token = ENV['SECRET_TOKEN']
  else
    begin
      file = Rails.root.to_s + "/config/secret_token"
      secret_token = open(file).read
      config.secret_token = secret_token
    rescue LoadError, Errno::ENOENT => e
      raise "Secret token couldn't be loaded! Error: #{e}"
    end
  end
end