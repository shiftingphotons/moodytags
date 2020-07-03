require 'rspotify'
Dotenv.load('.env.spotify')

if ENV['HANAMI_ENV'] != "test"
  RSpotify::authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_CLIENT_SECRET'])
end
