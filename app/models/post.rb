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
    c = Comment.includes(:comments, :author).order("created_at DESC").joins(:post).where(post_id: self.id).order("created_at DESC")
    c.select { |comment| comment.parent_comment_id.nil? }
  end

  def vote_count
    self.votes.inject(0) { |acc, vote| acc + vote.value }
  end


end
