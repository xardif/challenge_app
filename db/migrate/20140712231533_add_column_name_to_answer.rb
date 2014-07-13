class AddColumnNameToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :liked_by, :integer, array:true, default: []
  end
end
