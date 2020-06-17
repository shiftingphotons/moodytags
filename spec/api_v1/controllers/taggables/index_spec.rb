RSpec.describe "API V1 taggables" do
  include Rack::Test::Methods

  # app is required by Rack::Test
  let(:app) { Hanami.app }

  it "is successful" do
    get "/api/v1/taggables/"

    expect(last_response.status).to be(200)
  end
end
