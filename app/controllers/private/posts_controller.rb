module Private
  class PostsController < ::PrivateController
    
    def index
      posts = current_user.posts.includes(:comments)

      render json: posts, each_serializer: PostSerializer
    end

    def create
      service = CreatePostService.call(
        current_user,
        params[:title],
        params[:content]
      )

      if service.success?
        render json: service.result, serializer: PostSerializer
      else
        render json: { error: service.errors }, status: :unprocessable_entity
      end
    end

    def show
    end

    def update
    end
  end
end