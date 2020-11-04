# frozen_string_literal: true

module Api
  module Controllers
    module Taggables
      class Update
        include Api::Action

        before :validate

        params do
          required(:tags) { array? { each { str? } } }
        end

        def initialize
          @taggables_repo = TaggableRepository.new
        end

        def call(params)
          taggable = @taggables_repo.find(params[:id])
          halt 404 unless taggable

          updated_taggable = @taggables_repo.update(taggable.id, { tags: params.get(:tags) })
          self.body = JSON.generate(updated_taggable.to_h)
        end

        private

        def validate
          halt 400, params.errors.to_json unless params.valid?
        end

        def verify_csrf_token?
          false
        end
      end
    end
  end
end
