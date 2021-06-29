module Private
  class PostsController < ::PrivateController
    
    def index
      render json: {message: current_user.username}
    end

    def create
    end

    def show
    end

    def update
    end
  end
end