module ApiV1
  module Controllers
    module Spotify
      class GetPlaylists
        include ApiV1::Action

        def initialize
          RSpotify.raw_response = true
        end

        def call(params)
          page = 0
          if params[:page] && params[:page].to_i > 0
            page = params[:page].to_i - 1
          end

          response = @spotify_user.playlists(limit: 50, offset: 50 * page)
          playlists = JSON.parse(response.body)

          self.body = {items: playlists["items"], total: playlists["total"]}.to_json
        end
      end
    end
  end
end
