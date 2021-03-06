# frozen_string_literal: true

module Api
  module Validations
    module User
      class UserTagsValidator < Api::Action::Params
        include Hanami::Validations

        predicate :tag_keys?, message: 'must have a name, tags and order' do |tag_obj|
          keys = tag_obj.keys
          keys.length == 3 && %i[name tags order].all? { |key| keys.include? key }
        end

        predicate :name_str?, message: 'name must be string' do |tag_obj|
          tag_obj[:name].is_a?(String)
        end

        predicate :tags_arr?, message: 'tags should be array' do |tag_obj|
          tag_obj[:tags].is_a?(Array)
        end

        predicate :order_int?, message: 'order has to be an integer' do |tag_obj|
          begin
            Integer(tag_obj[:order])
          rescue ArgumentError
            false
          end
        end

        validations do
          required(:tags) { array? { each { hash? & tag_keys? & name_str? & tags_arr? & order_int? } } }
        end
      end
    end
  end
end
