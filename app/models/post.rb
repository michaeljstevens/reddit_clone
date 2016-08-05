class Post < ActiveRecord::Base
  validates :title, :author, presence: true
  validates :subs, length: { minimum: 1 }

  belongs_to :author,
    class_name: :User

  has_many :post_subs, dependent: :destroy

  has_many :subs, through: :post_subs

  has_many :votes, as: :votable

  # has_many :comments

  def comments
    c = Comment.includes(:comments, :author).joins(:post).where(post_id: self.id)
    c.select { |comment| comment.parent_comment_id.nil? }
  end

  def vote_count
  end


end
