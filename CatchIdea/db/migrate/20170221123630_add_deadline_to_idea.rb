class AddDeadlineToIdea < ActiveRecord::Migration[5.0]
  def change
    add_column :ideas, :deadline, :date
  end
end
