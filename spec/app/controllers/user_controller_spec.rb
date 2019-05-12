require 'spec_helper'

describe UserController do
  include Rack::Test::Methods

  let(:response) { post '/users', json, {'CONTENT_TYPE' => 'application/json'} }
  let(:body) { 
    binding.pry
    JSON.parse(response.body) }

  context "bad requests response without its two mandatory nodes" do
    let(:json){ {}.to_json }

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
    let(:json){ { "password": "testpassword" }.to_json }

    before do
      response
    end

    it { expect(body["error"]).to eq("The following fields (login) are missing!") }
    it { expect(body["field"].length).to eq(1) }
    it { expect(body["field"].first).to eq("login") }
    it { expect(response.status).to eq(400) }
  end

  context "bad requests response without login" do
    let(:json){ { "login": "somelogin@huaheuae.com" }.to_json }

    before do
      response
    end

    it { expect(body["error"]).to eq("The following fields (password) are missing!") }
    it { expect(body["field"].length).to eq(1) }
    it { expect(body["field"].first).to eq("password") }
    it { expect(response.status).to eq(400) }
  end

  context "success to create an user" do
    let(:json){ { "login": "test@test.com", "password": "passwordtest" }.to_json }
    let(:open_struct) { OpenStruct.new(:login => "test@test.com", :password => "passwordtest") }

    before do
      allow(CreateUsersService).to receive(:perform).and_return open_struct
      response
    end

    it { expect(body["login"]).to eq("test@test.com") }
  end

end
