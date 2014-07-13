class AddBadgedToUser < ActiveRecord::Migration
  def change
    add_column :users, :badged, :boolean, default: false
  end
end
