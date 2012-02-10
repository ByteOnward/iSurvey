Rails.application.config.middleware.use OmniAuth::Builder do
  
  provider :identity, :fields => [:email]
  
  provider :github, 'CONSUMER_KEY', 'CONSUMER_SECRET'
#  provider :sina, "consumer_key", "consumer_secret" 
  
end