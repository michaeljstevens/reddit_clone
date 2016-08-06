class Subscription < ActiveRecord::Base
  validates :user, :sub, presence: true

  belongs_to :user
  belongs_to :sub

end
