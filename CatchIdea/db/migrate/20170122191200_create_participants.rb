class CreateParticipants < ActiveRecord::Migration[5.0]
  def change
    create_table :participants do |t|
      t.integer :idea_id
      t.integer :user

      t.timestamps
    end
  end
end
