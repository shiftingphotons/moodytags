# frozen_string_literal: true

RSpec.describe 'API V1 get taggables' do
  include Rack::Test::Methods

  let(:app) { Hanami.app }
  let(:users) { UserRepository.new }
  let(:taggables_repo) { TaggableRepository.new }
  let(:user) { users.create({ token: 'QWE', refresh_token: 'RTY', ext_id: '39' }) }
  let!(:taggables) do
    taggables_repo.create(ext_id: '67yift3qAWE0DtAbuMF6mU', tags: %w[one two], user_id: user.id)
    taggables_repo.create(ext_id: '5B44sIZGyatbMPvogHOUUr', tags: %w[two], user_id: user.id)
  end

  before(:each) do
    login_as user
  end

  it 'is successful' do
    get '/api/v1/taggables'

    sections = JSON.parse(last_response.body)
    expect(last_response.status).to be 200
    expect(sections.keys).to eq %w[two one]
    expect(sections['one'].length).to be 1
    expect(sections['two'].length).to be 2
  end
end
