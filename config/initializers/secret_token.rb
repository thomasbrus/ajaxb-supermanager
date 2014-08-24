if Rails.env.development?
  Supermanager::Application.config.secret_token = '7064cbac5ee61da260507ebda710b548be3d3fb0d7efce4bd4c81ffa3f918cec52fac3f02dac495bafb30abf2fd9f5cab7f8199165b196277d3ca96a557e663a'
else
  Supermanager::Application.config.secret_token = ENV['SECRET_TOKEN']
end
