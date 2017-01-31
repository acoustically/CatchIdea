class AddPermissionToParticipants < ActiveRecord::Migration[5.0]
  def change
    add_column :participants, :permission, :integer
  end
end
