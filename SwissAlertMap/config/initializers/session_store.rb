# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_SwissAlertMap_session',
  :secret      => 'a8c28e87e8cbc6064598105c6ba9beaf1dd5f42a891dc87b2c81923e20342a53c388b0325769ecf9ff71d6ef6a7763357d32085bc75522490a91b725289944bc'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
