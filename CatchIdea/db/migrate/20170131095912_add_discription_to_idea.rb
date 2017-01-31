class AddDiscriptionToIdea < ActiveRecord::Migration[5.0]
  def change
    add_column :ideas, :discription, :text
  end
end
