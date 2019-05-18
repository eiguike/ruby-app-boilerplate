describe HealthCheckController do
  include Rack::Test::Methods

  context "GET /health" do
    let(:response) { get "/health" }
    let(:body) { JSON.parse(response.body) }

    it { expect(response.status).to eq(200) }
    it { expect(body["result"]).to eq("ok") }
  end

end

