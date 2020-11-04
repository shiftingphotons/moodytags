# frozen_string_literal: true

module Api
  module Authentication
    def self.included(action)
      action.class_eval do
        before :authenticate
        expose :current_user, :spotify_user
      end
    end

    private

    def authenticate
      halt 401 unless authenticated?
    end

    def authenticated?
      !!current_user && !!spotify_user
    end

    def current_user
      warden = request.env['warden']
      @current_user ||= warden.user
    end

    def spotify_user
      return unless @current_user

      spotify_details = {
        'credentials' => { 'token' => @current_user.token, 'refresh_token' => @current_user.refresh_token },
        'info' => { 'id' => @current_user.ext_id }
      }
      @spotify_user = RSpotify::User.new(spotify_details)
    end
  end
end
