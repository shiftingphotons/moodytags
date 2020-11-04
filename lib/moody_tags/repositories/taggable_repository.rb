# frozen_string_literal: true

class TaggableRepository < Hanami::Repository
  def find_by_user_id(user_id)
    taggables.where(user_id: user_id).to_a
  end
end
