class CreatePostService
  prepend SimpleCommand

  def initialize(user, title, content)
    @user = user
    @title = title
    @content = content
  end

  def call
    if valid?
      user.posts.create(title: title, content: content)
    end
  end

  private

  attr_accessor :user, :title, :content

  def valid?
    title_length_valid?
  end

  def title_length_valid?
    title && title.length <= Const::Service::Validates::POST_TITLE_MAX_LENGTH ||
      errors.add(:title, "Post title maximum length is #{Const::Service::Validates::POST_TITLE_MAX_LENGTH}")
  end
end