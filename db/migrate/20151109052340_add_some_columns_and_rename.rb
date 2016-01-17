class AddSomeColumnsAndRename < ActiveRecord::Migration
  def change

    add_column :verified_fields, :description, :string
    add_column :verification_lists, :category, :integer

  end
end
