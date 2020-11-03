# frozen_string_literal: true

module Api
  module Controllers
    module TagCollections
      class Index
        include Api::Action

        def initialize
          @tag_collections = TagCollectionRepository.new
        end

        def call
          tag_collection = @tag_collections.find_by_user_id(current_user.id)
          self.body = tag_collection.tags.to_json
        end
      end
    end
  end
end
