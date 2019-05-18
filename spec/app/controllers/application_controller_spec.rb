describe ApplicationController do
  include Rack::Test::Methods

  let(:read_os) { OpenStruct.new(read: {}) }
  let(:request_os) { OpenStruct.new(body: read_os) }
  let(:open_struct) { OpenStruct.new(request: request_os, params: { "login": "login@teste.com.br", "password": "password123" }) }
  let(:application) { ApplicationController.new(open_struct) }
  let(:parameters) { application.params }

  context "success params" do
    before do
      application.set_params do
        application.param login: { type: String }
        application.param password: { type: String } 
      end
    end

    it { expect(parameters.length).to eq(2) }
    it { expect(parameters[:login]).to eq("login@teste.com.br") }
    it { expect(parameters[:password]).to eq("password123") }
  end

  context "bad request params" do
    before do
      application.set_params do
        application.param login: { type: String }
        application.param password: { type: String } 
        application.param newData: { type: String } 
      end
    end

    it { expect{parameters}.to raise_error(BadRequestException) }
  end

end

