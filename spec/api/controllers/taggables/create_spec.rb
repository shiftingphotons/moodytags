# frozen_string_literal: true

RSpec.describe 'API V1 create taggable' do
  include Rack::Test::Methods

  let(:app) { Hanami.app }
  let(:users) { UserRepository.new }

  let(:user) { users.create({ token: 'QWE', refresh_token: 'RTY', ext_id: '39' }) }
  let(:taggables_repo) { TaggableRepository.new }

  before(:each) do
    login_as user
  end

  it 'is successful' do
    payload = { ext_id: '5B44sIZGyatbMPvogHOUUr', tags: %w[night] }
    post '/api/v1/taggables', payload

    response_taggable = JSON.parse(last_response.body)
    expect(last_response.status).to be(201)
    expect(response_taggable['tags']).to eq(['night'])
  end

  it 'received bad request' do
    payload = { "ext_id": 0 }
    post '/api/v1/taggables', payload
    expect(last_response.status).to be(400)
  end
end
