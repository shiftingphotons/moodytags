# frozen_string_literal: true

module Api
  module Controllers
    module TagCollections
      class Index
        include Api::Action

        def initialize
          @tag_collections_repo = TagCollectionRepository.new
        end

        def call(_)
          tag_collection = @tag_collections_repo.find_by_user_id(current_user.id)
          self.body = tag_collection.tags.to_json
        end
      end
    end
  end
end
