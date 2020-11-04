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
          @spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
          warden = request.env['warden']
          warden.set_user find_or_create_user
          redirect_to 'http://localhost:8080/app'
        end

        private

        def find_or_create_user
          user = @users_repo.find_by_ext_id(@spotify_user.id)
          return user unless user.nil?

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

        def authenticate!; end
      end
    end
  end
end
