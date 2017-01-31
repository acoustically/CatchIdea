class AddParticipantIdToContent < ActiveRecord::Migration[5.0]
  def change
    add_column :contents, :participant_id, :integer
  end
end
