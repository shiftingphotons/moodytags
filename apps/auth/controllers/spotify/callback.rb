require 'rspotify'

module Auth
  module Controllers
    module Spotify
      class Callback
        include Auth::Action

        def initialize
          @users = UserRepository.new
        end

        def call(params)
          warden = request.env['warden']
          spotify_user = RSpotify::User.new(request.env['omniauth.auth'])

          user = @users.by_ext_id(spotify_user.id)
          if !user
            user = @users.create(
              token: spotify_user.credentials.token,
              refresh_token: spotify_user.credentials.refresh_token,
              ext_id: spotify_user.id
            )
          end

					warden.set_user user

					# redirect_to "/"
          # TODO Redirect to home of app
          self.body = 'OK'
        end
      end
    end
  end
end
