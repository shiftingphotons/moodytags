module ApiV1
  module Controllers
    module Taggables
      class Create
        include ApiV1::Action

        params do
          required(:tags) { array? { each { str?  }  }  }
        end

        def initialize
          @taggables = TaggableRepository.new
        end

        def call(params)
          halt 400 unless params.valid?

          @taggables.create(tags: params[:tags], ext_id: params[:ext_id], user_id: current_user.id)
          status 201, []
        end

        private

        def verify_csrf_token?
          false
        end
      end
    end
  end
end
