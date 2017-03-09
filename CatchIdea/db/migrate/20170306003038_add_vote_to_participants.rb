class AddVoteToParticipants < ActiveRecord::Migration[5.0]
  def change
    add_column :participants, :vote, :integer
    add_column :participants, :comment, :text
  end
end
