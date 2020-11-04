# frozen_string_literal: true

require 'json'
require 'rspotify'

module Api
  module Controllers
    module Taggables
      class Index
        include Api::Action

        def initialize
          @taggables = TaggableRepository.new
          @playlists = []
          @sections = {}
          @grouped_taggables = []
        end

        def call(_)
          # Probably needs extracting as this logic is used on another place too
          @grouped_taggables = @taggables
                               .find_by_user_id(current_user.id)
                               .group_by(&:ext_id)

          # TODO
          # This outlines a problem - how do we know how many playlists we need to preload
          # since we can't know which of them are tagged without brute-force getting them one by one
          # Pending solution...
          # For now just get the first 200
          (0..150).step(50) do |offset|
            begin
              @playlists.concat @spotify_user.playlists(limit: 50, offset: offset)
            rescue RestClient::Unauthorized
              halt 401
            end
          end

          self.body = sections.to_json
        end

        private

        def make_unified_hash(playlist, taggable)
          {
            id: taggable.id,
            ext_id: playlist.id,
            name: playlist.name,
            images: playlist.images,
            uri: playlist.uri
          }
        end

        def sections
          @playlists.each do |p|
            next unless @grouped_taggables[p.id]

            t = @grouped_taggables[p.id].first
            playlist_hash = make_unified_hash(p, t)

            t.tags.each do |tag|
              if @sections[tag]
                @sections[tag] << playlist_hash
              else
                @sections[tag] = [playlist_hash]
              end
            end
          end
          @sections
        end

        def verify_csrf_token?
          false
        end
      end
    end
  end
end
