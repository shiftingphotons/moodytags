# frozen_string_literal: true

require 'rspotify'

module Api
  module Controllers
    module Auth
      class Spotify
        include Api::Action

        def initialize
          @users = UserRepository.new
          @tag_collections = TagCollectionRepository.new
        end

        def call
          warden = request.env['warden']
          spotify_user = RSpotify::User.new(request.env['omniauth.auth'])

          user = @users.find_by_ext_id(spotify_user.id)
          unless user
            user = @users.create(
              token: spotify_user.credentials.token,
              refresh_token: spotify_user.credentials.refresh_token,
              ext_id: spotify_user.id
            )
            @tag_collections.create(user_id: user.id)
          end

          warden.set_user user

          redirect_to 'http://localhost:8080/app'
        end

        private

        def authenticate!; end
      end
    end
  end
end
