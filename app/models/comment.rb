class Comment < ActiveRecord::Base
  validates :content, :author, :post, presence: true

  belongs_to :author,
    class_name: :User

  belongs_to :post

  has_many :comments,
  class_name: :Comment,
  foreign_key: :parent_comment_id,
  primary_key: :id

  belongs_to :parent_comment,
    class_name: :Comment

  has_many :votes, as: :votable


end
