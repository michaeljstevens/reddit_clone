class Post < ActiveRecord::Base
  validates :title, :sub, :author, presence: true

  belongs_to :author,
    class_name: :User,
    dependent: :destroy

  belongs_to :sub,
  dependent: :destroy

end
