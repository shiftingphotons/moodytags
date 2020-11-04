# frozen_string_literal: true

require 'rspotify'
Dotenv.load('.env.spotify')
RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_CLIENT_SECRET']) if ENV['HANAMI_ENV'] != 'test'
