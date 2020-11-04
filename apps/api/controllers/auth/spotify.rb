# frozen_string_literal: true

require 'rspotify'

module Api
  module Controllers
    module Auth
      class Spotify
        include Api::Action

        def initialize
          @warden = request.env['warden']
          @users = UserRepository.new
          @tag_collections = TagCollectionRepository.new

          @spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
        end

        def call(_)
          set_or_create_user
          @warden.set_user @user
          redirect_to 'http://localhost:8080/app'
        end

        private

        def set_or_create_user
          @user = @users.find_by_ext_id(spotify_user.id)
          return unless @user

          @user = @users.create(
            token: spotify_user.credentials.token,
            refresh_token: spotify_user.credentials.refresh_token,
            ext_id: spotify_user.id
          )
          @tag_collections.create(user_id: @user.id)
        end

        def authenticate!; end
      end
    end
  end
end
