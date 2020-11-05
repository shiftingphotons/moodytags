# frozen_string_literal: true

RSpec.describe 'API V1 get playlists' do
  include Rack::Test::Methods

  let(:app) { Hanami.app }
  let(:users) { UserRepository.new }
  let(:user) { users.create({ token: 'QWE', refresh_token: 'RTY', ext_id: '39' }) }

  before(:each) do
    login_as user
  end

  it 'is successful' do
    get '/api/v1/playlists'

    json_body = JSON.parse(last_response.body)
    expect(last_response.status).to be 200
    expect(json_body['items'].length).to be 2
    expect(json_body['total']).to be 2
  end
end
