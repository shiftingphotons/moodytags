# frozen_string_literal: true

module Api
  module Controllers
    module TagCollections
      class Update
        include Api::Action

        params Api::Validations::TagCollections::TagCollectionsValidator

        def initialize
          @tag_collections = TagCollectionRepository.new
        end

        def call(params)
          tags = params.get(:tags)
          unless params.valid?
            self.status = 400
            self.body = params.errors.to_json
            return
          end
          tag_collection = @tag_collections.find_by_user_id(current_user.id)
          @tag_collections.update(tag_collection.id, tags: tags)

          self.status = 200
        end

        private

        def verify_csrf_token?
          false
        end
      end
    end
  end
end
