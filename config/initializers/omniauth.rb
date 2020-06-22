require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, "98f9ebb06dae4715bec40fb61b34c2b0", "931d0310113e4defb19f6e5493c9fe4d", scope: 'user-library-read playlist-read-collaborative playlist-modify-private playlist-modify-public playlist-read-private'
end
