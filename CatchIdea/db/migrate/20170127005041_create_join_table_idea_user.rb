class CreateJoinTableIdeaUser < ActiveRecord::Migration[5.0]
  def change
    create_join_table :ideas, :users do |t|
      # t.index [:idea_id, :user_id]
      # t.index [:user_id, :idea_id]
    end
  end
end
