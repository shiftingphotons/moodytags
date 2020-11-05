# frozen_string_literal: true

RSpec.describe 'API V1 update user tags' do
  include Rack::Test::Methods

  let(:app) { Hanami.app }
  let(:users) { UserRepository.new }
  let(:tag_collections_repo) { TagCollectionRepository.new }
  let!(:user) { users.create({ token: 'QWE', refresh_token: 'RTY', ext_id: '39' }) }
  let!(:tag_collection) { tag_collections_repo.create({ user_id: user.id }) }

  before(:each) do
    login_as user
  end

  context 'with valid params' do
    it 'is successful and tags are updated' do
      updated_tags = { tags: [
        { name: 'genre', tags: %w[jazz pop], order: '0' },
        { name: 'decade', tags: %w[80s 90s], order: '1' }
      ] }

      header 'Content-Type', 'application/json'
      put '/api/v1/tag_collections', updated_tags.to_json
      expect(last_response.status).to be 200

      user_tags = tag_collections_repo.find_by_user_id(user.id).tags
      user_tags.each { |t| t.transform_keys!(&:to_sym) }
      expect(user_tags).to eq updated_tags[:tags]
    end
  end

  context 'with invalid params' do
    it 'returns error code when it received strings instead of hashes' do
      bad_tags_paylod = { tags: %w[winter summer] }

      header 'Content-Type', 'application/json'
      put '/api/v1/tag_collections', bad_tags_paylod.to_json
      expect(last_response.status).to be 400
    end

    it 'returns error code when it received hashes but with the wrong keys' do
      bad_tags_paylod = { tags: [
        { tags: %w[jazz pop] },
        { tags: %w[80s 90s], order: 1 }
      ] }

      header 'Content-Type', 'application/json'
      put '/api/v1/tag_collections', bad_tags_paylod.to_json
      expect(last_response.status).to be 400
    end

    it 'returns error code when it received the right keys, but invalid values' do
      bad_tags_paylod = { tags: [
        { name: [], tags: 'one', order: '0' },
        { name: '', tags: 'one', order: '1' }
      ] }

      header 'Content-Type', 'application/json'
      put '/api/v1/tag_collections', bad_tags_paylod.to_json
      expect(last_response.status).to be 400
    end
  end
end
