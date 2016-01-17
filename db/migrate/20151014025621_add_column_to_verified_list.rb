class AddColumnToVerifiedList < ActiveRecord::Migration
  def change
    add_reference :verified_lists, :procedure, index: true, foreign_key: true
    remove_column :verified_lists, :employee_id
  end
end
