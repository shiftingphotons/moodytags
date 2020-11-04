# frozen_string_literal: true

module Api
  module Controllers
    module Spotify
      class GetPlaylists
        include Api::Action

        def initialize
          RSpotify.raw_response = true
        end

        def call(params)
          page = page_param(params)
          @playlists = fetch_playlists page

          group_taggables
          assign_playlist_tags
          self.body = { items: @playlists['items'], total: @playlists['total'] }.to_json
        end

        private

        def group_taggables
          @taggables = TaggableRepository.new
                                         .find_by_user_id(current_user.id)
                                         .group_by(&:ext_id)
        end

        def page_param(params)
          return 0 unless params[:page]

          page = params[:page]&.to_i
          return page - 1 if page&.positive?
        end

        def fetch_playlists(page)
          begin
            response = @spotify_user.playlists(limit: 50, offset: 50 * page)
          rescue RestClient::Unauthorized
            # There is a uncatched bug here - this could also be because a token needs to be refreshed
            # OR most probably WAS refreshed but not saved to the db?
            halt 401
          end

          JSON.parse(response.body)
        end

        def assign_playlist_tags
          @playlists['items'].each do |p|
            p_id = p['id']
            p[:tags] = []

            next unless @taggables.include? p_id

            p[:tags] << @taggables[p_id].first.tags
            p[:taggable_id] = @taggables[p_id].first.id
          end
        end
      end
    end
  end
end
