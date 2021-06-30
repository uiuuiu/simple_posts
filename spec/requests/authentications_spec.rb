require 'rails_helper'

RSpec.describe "Authentication", type: :request do
  before do
    User.create(username: 'dy', password: '12345678')
  end

  describe "POST /authentication" do
    context "Success" do
      before do
        body = { username: 'dy', password: '12345678' }
        post authenticate_path, params: body
      end

      it 'has status 200' do
        expect(response).to have_http_status(200)
      end

      it 'has auth_token in response body' do
        data = JSON.parse(response.body)
        expect(data['auth_token']).not_to be_empty
      end

      it 'can use auth_token to request private api' do
        data = JSON.parse(response.body)
        headers = { "Authorization" => data['auth_token'] }
      
        get me_posts_path, headers: headers
        expect(response).to have_http_status(200)

        data = JSON.parse(response.body)
        expect(data['message']).not_to be_empty
      end
    end

    context "Fail" do

      it 'username is not exist' do
        body = { username: 'dy1', password: '12345678' }
        post authenticate_path, params: body

        data = JSON.parse(response.body)
        expect(response).to have_http_status(401)
        expect(data["error"]["user_authentication"]).to eq('invalid credentials')
      end

      it 'password is not correct' do
        body = { username: 'dy', password: '123456' }
        post authenticate_path, params: body

        data = JSON.parse(response.body)
        expect(response).to have_http_status(401)
        expect(data["error"]["user_authentication"]).to eq('invalid credentials')
      end

      it 'username is empty' do
        body = { username: '', password: '123456' }
        post authenticate_path, params: body

        data = JSON.parse(response.body)
        expect(response).to have_http_status(401)
        expect(data["error"]["user_authentication"]).to eq('invalid credentials')
      end

      it 'password is empty' do
        body = { username: 'dy', password: '' }
        post authenticate_path, params: body

        data = JSON.parse(response.body)
        expect(response).to have_http_status(401)
        expect(data["error"]["user_authentication"]).to eq('invalid credentials')
      end
    end
  end
end
