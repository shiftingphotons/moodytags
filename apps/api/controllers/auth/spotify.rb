require 'rspotify'

module Api
  module Controllers
    module Auth
      class Spotify
        include Api::Action

        def initialize
          @users = UserRepository.new
        end

        def call(params)
          warden = request.env['warden']
          spotify_user = RSpotify::User.new(request.env['omniauth.auth'])

          user = @users.find_by_ext_id(spotify_user.id)
          if !user
            user = @users.create(
              token: spotify_user.credentials.token,
              refresh_token: spotify_user.credentials.refresh_token,
              ext_id: spotify_user.id
            )
          end

          warden.set_user user

          redirect_to "http://localhost:8080"
        end

        private
        def authenticate!

        end
      end
    end
  end
end
