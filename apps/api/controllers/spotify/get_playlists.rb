# frozen_string_literal: true

module Api
  module Controllers
    module Spotify
      class GetPlaylists
        include Api::Action

        before :set_page, :set_taggables, :set_playlists

        def initialize
          RSpotify.raw_response = true
          @page = 0
        end

        def call(_)
          @playlists.each do |playlist|
            playlist[:tags] = []
            next unless @taggables.include? playlist['id']

            taggable = @taggables[playlist['id']].first
            playlist[:tags] += taggable.tags
            playlist[:taggable_id] = taggable.id
          end

          self.body = { items: @playlists, total: @playlist_count }.to_json
        end

        private

        def set_taggables
          @taggables = TaggableRepository.new
                                         .find_by_user_id(current_user.id)
                                         .group_by(&:ext_id)
        end

        def set_page
          page_param = params[:page]&.to_i
          return unless page_param

          @page = page_param - 1 if page_param.positive?
        end

        def set_playlists
          begin
            response = @spotify_user.playlists(limit: 25, offset: 25 * @page)
          rescue RestClient::Unauthorized
            # There is a uncatched bug here - this could also be because a token needs to be refreshed
            # OR most probably WAS refreshed but not saved to the db?
            halt 401
          end

          json_body = JSON.parse(response.body)
          @playlists = json_body.fetch('items')
          @playlist_count = json_body.fetch('total')
        end
      end
    end
  end
end
