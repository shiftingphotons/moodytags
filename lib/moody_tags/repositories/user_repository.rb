class UserRepository < Hanami::Repository
  def by_ext_id(ext_id)
    users.where(ext_id: ext_id).one
  end
end
