class AddIsShowToContents < ActiveRecord::Migration[5.0]
  def change
    add_column :contents, :is_show, :boolean
  end
end
