require 'json'

module ApiV1
  module Controllers
    module Taggables
      class Index
        include ApiV1::Action

        def call(params)
          taggables = TaggableRepository.new
          self.body = {taggables: taggables.all.map(&:to_h)}.to_s
        end
      end
    end
  end
end
