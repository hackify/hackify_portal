#OmniAuth.config.logger = Rail.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :developer unless Rails.env.production?
  #provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  if Rails.env.production?
    provider :github, '896a6e1147188379abd0', 'ced9d1d6b3c5ed960ec4a179ec5455ec0128e28a'
  else
    provider :github, '5e3cd15f7140278106d7', '2efd62e1d5faa4a6a3231d734ce375ca54656bfa'
  end

end