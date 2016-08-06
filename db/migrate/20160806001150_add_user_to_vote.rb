class AddUserToVote < ActiveRecord::Migration
  def change
    add_column :votes, :user_id, :integer
    add_index :votes, [:user_id, :votable_id, :votable_type], unique: true
  end
end
