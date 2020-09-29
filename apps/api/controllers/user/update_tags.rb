module Api
  module Controllers
    module User
      class UpdateTags
        include Api::Action

        params Api::Validations::User::UserTagsValidator

        def initialize
          @users = UserRepository.new
        end

        def call(params)
          tags = params.get(:tags)
          if !params.valid?
            self.status = 400
            self.body = params.errors.to_json
            return
          end

          @users.update(current_user.id, tags: tags)
          self.status = 200
        end
      end
    end
  end
end
