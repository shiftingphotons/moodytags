# frozen_string_literal: true

RSpec.describe 'API V1 get user tags' do
  include Rack::Test::Methods

  let(:app) { Hanami.app }
  let(:users) { UserRepository.new }
  let(:tag_collections_repo) { TagCollectionRepository.new }
  let(:user) { users.create({ token: 'QWE', refresh_token: 'RTY', ext_id: '39' }) }
  let!(:tag_collection) { tag_collections_repo.create({ user_id: user.id }) }

  before(:each) do
    login_as user
  end

  it 'is successful' do
    get '/api/v1/tag_collections'

    tag_collection = JSON.parse(last_response.body)
    all_keys_present = tag_collection.all? { |t| t.keys == %w[name tags order] }

    expect(all_keys_present).to be true
    expect(last_response.status).to be 200
  end
end
