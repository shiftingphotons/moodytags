RSpec.describe "API V1 update taggable" do
  include Rack::Test::Methods

  # app is required by Rack::Test
  let(:app) { Hanami.app }
  let(:taggable) { TaggableRepository.new.create(ext_user_id: '01', ext_id: "10", tags: ["day"]) }

  it "is successful" do
    payload = {tags: ["night"]}
    patch "/api/v1/taggables/#{ taggable.id }", payload

    response_taggable = JSON.parse(last_response.body)
    expect(last_response.status).to be(200)
    expect(response_taggable["tags"]).to eq(["night"])
  end

  it "received bad request" do
    payload = {"ext_id": 0}
    patch "/api/v1/taggables/#{ taggable.id }", payload
    expect(last_response.status).to be(400)
  end

  it "received missing id" do
    payload = {tags: ["night"]}
    patch "/api/v1/taggables/0", payload
    expect(last_response.status).to be(404)
  end
end
