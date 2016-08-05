class Vote < ActiveRecord::Base
  validates :value, inclusion: [1, -1]
  belongs_to :votable, polymorphic: true
end
