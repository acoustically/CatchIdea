class CreateIdeas < ActiveRecord::Migration[5.0]
  def change
    create_table :ideas do |t|
      t.integer :user_id
      t.string :name

      t.timestamps
    end
  end
end
