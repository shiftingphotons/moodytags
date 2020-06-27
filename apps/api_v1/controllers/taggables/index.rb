require 'json'
require 'rspotify'

module ApiV1
  module Controllers
    module Taggables
      class Index
        include ApiV1::Action

        def initialize
          @taggables = TaggableRepository.new
        end

        def call(params)
          sections = {
            untagged: []
          }

          playlists = @spotify_user.playlists(limit: 50, offset: 0)
          grouped_taggables = @taggables.find_by_user_id(current_user.id).group_by {|t| t.ext_id}

          # byebug
          for p in playlists do
            playlist_hash = {
              id: p.id,
              name: p.name,
              images: p.images,
              uri: p.uri
            }

            if grouped_taggables[p.id]
              tags = grouped_taggables[p.id].first.tags
              for tag in tags do
                if sections[tag]
                  sections[tag] << playlist_hash
                else
                  sections[tag] = [playlist_hash]
                end
              end
            end
          end

          byebug
          self.body = sections.to_json
        end
      end
    end
  end
end
