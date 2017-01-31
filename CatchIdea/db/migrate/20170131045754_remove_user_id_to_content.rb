class RemoveUserIdToContent < ActiveRecord::Migration[5.0]
  def change
		remove_column :contents, :idea_id
  end
end
