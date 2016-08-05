class FixSubDescription < ActiveRecord::Migration
  def change
    remove_column :subs, :desription
    add_column :subs, :description, :string, null: false
  end
end
