# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_pingtag_session',
  :secret      => '2e686a138bce09905f9863059d307a0c629653aba6db328da67b5f48695fcfe05b0ba9a10bf5bc95c7895cbe80efb4fb71791d66c1628a7ff0000071732647db'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
