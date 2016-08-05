class Post < ActiveRecord::Base
  validates :title, :author, presence: true
  validates :subs, length: { minimum: 1 }

  belongs_to :author,
    class_name: :User

  has_many :post_subs, dependent: :destroy

  has_many :subs, through: :post_subs


end
