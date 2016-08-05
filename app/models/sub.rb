class Sub < ActiveRecord::Base
  validates :title, :description, :moderator, presence: true

  has_many :posts

  belongs_to :moderator,
    class_name: :User,
    dependent: :destroy
end
