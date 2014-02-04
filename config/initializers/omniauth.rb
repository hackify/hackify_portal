#OmniAuth.config.logger = Rail.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :developer unless Rails.env.production?
  #provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  provider :github, '5e3cd15f7140278106d7', '2efd62e1d5faa4a6a3231d734ce375ca54656bfa'
end