describe UserController do
  include Rack::Test::Methods

  let(:body) { JSON.parse(response.body) }

  context "POST /users" do
    let(:response) { post "/users", json, {"CONTENT_TYPE" => "application/json"} }

    context "bad requests response without its two mandatory nodes" do
      let(:json) { {}.to_json }

      before do
        response
      end

      it { expect(body["error"]).to eq("The following fields (login, password) are missing!") }
      it { expect(body["field"].length).to eq(2) }
      it { expect(body["field"].first).to eq("login") }
      it { expect(body["field"].second).to eq("password") }
      it { expect(response.status).to eq(400) }
    end

    context "bad requests response without login" do
      let(:json) { {"password": "testpassword"}.to_json }

      before do
        response
      end

      it { expect(body["error"]).to eq("The following fields (login) are missing!") }
      it { expect(body["field"].length).to eq(1) }
      it { expect(body["field"].first).to eq("login") }
      it { expect(response.status).to eq(400) }
    end

    context "bad requests response without login" do
      let(:json) { {"login": "somelogin@huaheuae.com"}.to_json }

      before do
        response
      end

      it { expect(body["error"]).to eq("The following fields (password) are missing!") }
      it { expect(body["field"].length).to eq(1) }
      it { expect(body["field"].first).to eq("password") }
      it { expect(response.status).to eq(400) }
    end

    context "success to create an user" do
      let(:json) { {"login": "test@test.com", "password": "passwordtest"}.to_json }
      let(:open_struct) { OpenStruct.new(login: "test@test.com", password: "passwordtest") }

      before do
        allow(CreateUsersService).to receive(:perform).and_return open_struct
        response
      end

      it { expect(body["login"]).to eq("test@test.com") }
    end
  end

  context "GET /users/:login" do
    let(:response) { get "/users/#{login}", {"CONTENT_TYPE" => "application/json"} }

    before do
      response
    end

    context "when an account exists" do
      let(:login) { create(:user).login }

      it { expect(response.status).to eq(200) }
      it { expect(body["login"]).to eq(login) }
    end

    context "when an account does not exists" do
      let(:login) { Faker::Lorem.characters(10) }

      it { expect(response.status).to eq(404) }
      it { expect(body["error"]).to eq("login not found") }
      it { expect(body["field"]).to eq("login") }
    end
  end

  context "PATCH /users/:login" do
  end

  context "DELETE /users/:login" do
  end
end
