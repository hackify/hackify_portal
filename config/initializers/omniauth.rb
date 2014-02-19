#OmniAuth.config.logger = Rail.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, CONFIG[:twitter_key], CONFIG[:twitter_secret]
end