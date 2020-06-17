RSpec.describe ApiV1.routes do
  it 'recognizes "GET /ping"' do
    env   = Rack::MockRequest.env_for('/ping')
    route = described_class.recognize(env)

    expect(route.routable?).to be(true)

    expect(route.path).to   eq('/ping')
    expect(route.verb).to   eq('GET')
    expect(route.params).to eq({})
  end
end
