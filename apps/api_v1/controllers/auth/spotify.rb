require 'rspotify'

module ApiV1
  module Controllers
    module Auth
      class Spotify
        include ApiV1::Action

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

          redirect_to "/app"
        end

        private
        def authenticate!

        end
      end
    end
  end
end
