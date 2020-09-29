RSpec.describe "API V1 get user tags" do
  include Rack::Test::Methods

  let(:app) { Hanami.app }
  let(:users) { UserRepository.new }
  let(:user) { users.create({token: "QWE", refresh_token: "RTY", ext_id: "39"}) }

  before(:each) do
    login_as user
  end


  it "is successful" do
    get "/api/v1/user/tags"

    tags_arr = JSON.parse(last_response.body)
    all_keys_present = tags_arr.all? {|t| t.keys == ["name", "tags", "order"]}

    expect(all_keys_present).to be true
    expect(last_response.status).to be 200
  end
end
