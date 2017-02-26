class AddSubtitleToIdeas < ActiveRecord::Migration[5.0]
  def change
    add_column :ideas, :subtitle, :string
  end
end
