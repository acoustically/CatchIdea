class AddCurrentIdToFriend < ActiveRecord::Migration[5.0]
  def change
    add_column :friends, :current_id, :integer
		remove_column :friends, :email
  end
end
