class TagCollectionRepository < Hanami::Repository
  def find_by_user_id(user_id)
    tag_collections.where(user_id: user_id).one
  end
end
