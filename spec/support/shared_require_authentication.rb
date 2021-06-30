RSpec.shared_examples "require authentication", :shared_context => :metadata do 
  context "with valid auth token" do
    before do
      raise "Please declare user: let(:user) {...} in the running spec." unless user
      post authenticate_path, params: { username: user.username, password: user.password }
      data = JSON.parse(response.body)

      send(request_info[:method], request_info[:path], params: request_info[:params], headers: {'Authorization' => data['auth_token']})
    end

    it 'return 200 status' do
      expect(response).to have_http_status(200)
    end
  end

  context "without invalid auth token" do
    before do
      send(request_info[:method], request_info[:path], headers: {'Authorization' => 'invalid token'})
    end

    it 'return 401 status' do
      expect(response).to have_http_status(401)
    end
  end
end