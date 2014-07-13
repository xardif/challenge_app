class ChangeColumnNameToAnswer < ActiveRecord::Migration
  def change
    change_column :answers, :liked_by, :integer, array:true, default: '{}'
  end
end
