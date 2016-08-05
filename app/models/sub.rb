class Sub < ActiveRecord::Base
  validates :title, :description, :moderator, presence: true

  has_many :post_subs, dependent: :destroy
  has_many :posts, through: :post_subs, dependent: :destroy

  belongs_to :moderator,
    class_name: :User,
    dependent: :destroy
end
