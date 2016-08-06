class Sub < ActiveRecord::Base
  validates :title, :description, :moderator, presence: true

  has_many :post_subs, dependent: :destroy
  has_many :posts, through: :post_subs, dependent: :destroy

  has_many :subscribers,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :moderator,
    class_name: :User,
    dependent: :destroy
end
