class UserTagsValidator
	include Hanami::Validations

  predicate :tag_keys?, message: 'must have a name, tags and order' do |tag_obj|
    keys = tag_obj.keys
    keys.length == 3 && [:name, :tags, :order].all? { |s| keys.include? s }
  end

  predicate :types?, message: 'name must be string, tags should be array and order have to be an integer' do |tag_obj|
    tag_obj[:name].kind_of?(String) &&
    tag_obj[:tags].kind_of?(Array) &&
    Integer(tag_obj[:order]) rescue false
  end

	validations do
		required(:tags) { array? { each { hash? & tag_keys? & types? }  }  }
	end
end

module Api
  module Controllers
    module User
      class UpdateTags
        include Api::Action

        def initialize
          @users = UserRepository.new
        end

        def call(params)
          tags = params.get(:tags)
          tags_validation = UserTagsValidator.new(tags: tags).validate
          if tags_validation.failure?
            self.status = 400
            self.body = tags_validation.errors.to_json
            return
          end

          @users.update(current_user.id, tags: tags)
          self.status = 200
        end
      end
    end
  end
end
