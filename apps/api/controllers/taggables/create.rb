# frozen_string_literal: true

module Api
  module Controllers
    module Taggables
      class Create
        include Api::Action

        params do
          required(:tags) { array? { each { str? } } }
        end

        def initialize
          @taggables_repo = TaggableRepository.new
        end

        def call(params)
          validate params
          @taggables_repo.create(tags: params[:tags], ext_id: params[:ext_id], user_id: current_user.id)
          status 201, []
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
