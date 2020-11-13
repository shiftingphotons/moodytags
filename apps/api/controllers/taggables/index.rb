# frozen_string_literal: true

require 'json'
require 'rspotify'

module Api
  module Controllers
    module Taggables
      class Index
        include Api::Action
        # TODO: Most of the logic here is identical to that of another endpoint
        # unify them into single class?

        before :set_taggables, :fetch_playlists

        def initialize
          RSpotify.raw_response = true
          @playlists = []
          @sections = {}
        end

        def call(_)
          @playlists.each do |playlist|
            next unless @taggables[playlist['id']]

            taggable = @taggables[playlist['id']].first
            update_tag_section(taggable, playlist)
          end
          self.body = @sections.to_json
        end

        private

        def set_taggables
          @taggables = TaggableRepository.new
                                         .find_by_user_id(current_user.id)
                                         .group_by(&:ext_id)
        end

        def fetch_playlists
          # TODO
          # This outlines a problem - how do we know how many playlists we need to preload
          # since we can't know which of them are tagged without brute-force getting them one by one
          # Pending solution...
          # For now just get the first 200
          (0..150).step(50) do |offset|
            begin
              response = JSON.parse(@spotify_user.playlists(limit: 50, offset: offset))
            rescue RestClient::Unauthorized
              halt 401
            end
            @playlists.concat response['items']
            break if response['total'] < offset + 50
          end
        end

        def update_tag_section(taggable, playlist)
          tagged_playlist = {
            id: taggable.id, ext_id: playlist['id'],
            name: playlist['name'], images: playlist['images'],
            uri: playlist['uri']
          }

          taggable.tags.each do |tag|
            if @sections.include? tag
              @sections[tag] << tagged_playlist
            else
              @sections[tag] = [tagged_playlist]
            end
          end
        end

        def verify_csrf_token?
          false
        end
      end
    end
  end
end
