class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content
  has_many :comments, serializer: CommentPreviewSerializer
end