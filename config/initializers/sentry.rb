Raven.configure do |config|
  config.server = 'https://b11ac6010bef42468e8505315236fe35:6d2ba42d2bb14899b9dd75bb6e2d579c@sentry.io/96531'
  config.environments = ['production']

  # See https://docs.sentry.io/clients/ruby/config/
  config.processors -= [Raven::Processor::PostData] # Do this to send POST data
  config.processors -= [Raven::Processor::Cookies] # Do this to send cookies by default
end
