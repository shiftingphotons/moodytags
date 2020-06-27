class UserRepository < Hanami::Repository
  associations do
    has_many :taggables
  end

  def by_ext_id(ext_id)
    users.where(ext_id: ext_id).one
  end

  def find_with_taggables(ext_id)
    aggregate(:taggables).where(ext_id: ext_id).as(User).one
  end
end
