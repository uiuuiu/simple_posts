require 'rails_helper'

RSpec.describe "User manages posts", type: :request do
  let(:user) do
    User.first || User.create(username: 'dy', password: '12345678')
  end

  before do
    post1 = user.posts.create(title: 'Post 1', content: 'Content 1')
    post2 = user.posts.create(title: 'Post 2', content: 'Content 2')
  end

  describe "GET /me/posts" do
    context "Authentication" do
      let(:request_info) do
        {
          method: :get,
          path: me_posts_path
        }
      end

      it_behaves_like 'require authentication'
    end
  end

  describe "POST /me/posts" do
    let(:valid_params) {
      { title: 'Test', content: 'Test' }
    }

    let(:invalid_title_param) {
      { title: Faker.paragraph_by_chars(number: 101), content: 'Test' }
    }

    context "Authentication" do
      let(:request_info) do
        {
          method: :post,
          path: me_posts_path,
          params: {
            title: 'Test',
            content: 'Test'
          }
        }
      end

      it_behaves_like 'require authentication'
    end
  end
end