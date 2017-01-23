class CreateContents < ActiveRecord::Migration[5.0]
  def change
    create_table :contents do |t|
      t.integer :idea_id
      t.text :opinion
      t.integer :user_id

      t.timestamps
    end
  end
end
