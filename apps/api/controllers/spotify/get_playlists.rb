# frozen_string_literal: true

module Api
  module Controllers
    module Spotify
      class GetPlaylists
        include Api::Action

        def initialize
          RSpotify.raw_response = true
          @taggables = TaggableRepository.new
          @grouped_taggables = []
        end

        def call(params)
          @page = page(params)
          fetch_playlists

          @grouped_taggables << @taggables
                                .find_by_user_id(current_user.id)
                                .group_by(&:ext_id)

          set_taggables
          self.body = { items: @playlists['items'], total: @playlists['total'] }.to_json
        end

        private

        def page(params)
          return 0 unless params[:page]

          page = params[:page]&.to_i
          return page - 1 if page&.positive?
        end

        def set_taggables
          @playlists['items'].each do |p|
            p_id = p['id']
            p[:tags] = []

            next unless @grouped_taggables.include? p_id

            p[:tags] << @grouped_taggables[p_id].first.tags
            p[:taggable_id] = @grouped_taggables[p_id].first.id
          end
        end

        def fetch_playlists
          begin
            response = @spotify_user.playlists(limit: 50, offset: 50 * @page)
          rescue RestClient::Unauthorized
            # There is a uncatched bug here - this could also be because a token needs to be refreshed
            # OR most probably WAS refreshed but not saved to the db?
            halt 401
          end

          @playlists = JSON.parse(response.body)
        end
      end
    end
  end
end
