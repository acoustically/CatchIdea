class RemoveIsShowToContents < ActiveRecord::Migration[5.0]
  def change
    remove_column :contents, :is_show
  end
end
