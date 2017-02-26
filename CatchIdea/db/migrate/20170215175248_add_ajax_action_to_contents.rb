class AddAjaxActionToContents < ActiveRecord::Migration[5.0]
  def change
    add_column :contents, :ajax_action, :string
  end
end
