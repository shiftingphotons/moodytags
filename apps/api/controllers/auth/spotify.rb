# frozen_string_literal: true

require 'rspotify'

module Api
  module Controllers
    module Auth
      class Spotify
        include Api::Action

        def initialize
          @users_repo = UserRepository.new
          @tag_collections_repo = TagCollectionRepository.new
        end

        def call(_)
          env = request.env
          @spotify_user = RSpotify::User.new(env['omniauth.auth'])
          warden = env['warden']

          warden.set_user find_or_create_user
          redirect_to ENV['REDIRECT_URL_VUE_APP']
        end

        private

        def find_or_create_user
          user = @users_repo.find_by_ext_id(@spotify_user.id)
          return user if user

          create_user
        end

        def create_user
          created_user = @users_repo.create(
            token: @spotify_user.credentials.token,
            refresh_token: @spotify_user.credentials.refresh_token,
            ext_id: @spotify_user.id
          )
          @tag_collections_repo.create(user_id: created_user.id)
          created_user
        end

        def authenticate; end
      end
    end
  end
end
