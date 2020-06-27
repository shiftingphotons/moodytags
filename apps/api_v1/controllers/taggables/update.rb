module ApiV1
  module Controllers
    module Taggables
      class Update
        include ApiV1::Action

        params do
          required(:tags) { array? }
        end

        def initialize()
          @repository = TaggableRepository.new
        end

        def call(params)
          byebug
          if params.valid?
            taggable = @repository.find(params[:id])
            # TODO Fix the mess
            if taggable.nil?
              halt 404
            end
            updated_taggable = @repository.update(taggable.id, {tags: params.get(:tags)})
            self.body = JSON.generate(updated_taggable.to_h)
          else
            self.status = 400
          end
        end
      end
    end
  end
end
