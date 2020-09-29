module Api
  module Controllers
    module User
      class GetTags
        include Api::Action

        def call(params)
          self.body = current_user.tags.to_json
        end
      end
    end
  end
end
