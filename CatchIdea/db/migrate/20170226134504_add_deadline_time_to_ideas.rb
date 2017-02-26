class AddDeadlineTimeToIdeas < ActiveRecord::Migration[5.0]
  def change
    add_column :ideas, :deadline_time, :string
  end
end
