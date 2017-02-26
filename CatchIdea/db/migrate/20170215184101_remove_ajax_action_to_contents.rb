class RemoveAjaxActionToContents < ActiveRecord::Migration[5.0]
  def change
    remove_column :contents, :ajax_action, :is_show
  end
end
