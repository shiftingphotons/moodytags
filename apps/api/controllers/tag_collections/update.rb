# frozen_string_literal: true

module Api
  module Controllers
    module TagCollections
      class Update
        include Api::Action

        params Api::Validations::TagCollections::TagCollectionsValidator

        def initialize
          @tag_collections_repo = TagCollectionRepository.new
        end

        def call(params)
          validate params
          tags = params.get(:tags)
          tag_collection = @tag_collections_repo.find_by_user_id(current_user.id)
          @tag_collections_repo.update(tag_collection.id, tags: tags)
          self.status = 200
        end

        private

        def validate(params)
          halt 400, params.errors.to_json unless params.valid?
        end

        def verify_csrf_token?
          false
        end
      end
    end
  end
end
