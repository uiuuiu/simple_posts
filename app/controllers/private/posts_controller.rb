module Private
  class PostsController < ::PrivateController
    
    def index
      render json: {message: "ok"}
    end
  end
end