class ChangeColumnTypeUsers < ActiveRecord::Migration
  def change
    change_column :users, :password_alteration, :integer, :default => 0
  end
end
