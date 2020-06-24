require 'json'
require 'rspotify'

module ApiV1
  module Controllers
    module Taggables
      class Index
        include ApiV1::Action

        before :current_user

        def initialize
          @taggables = TaggableRepository.new
        end

        def call(params)
          if @current_user.nil?
            return status 401, []
          end
          self.body = {taggables: @taggables.all.map(&:to_h)}.to_s
        end

				private
        def current_user
          @current_user = request.env['warden'].user
        end

      end
    end
  end
end
