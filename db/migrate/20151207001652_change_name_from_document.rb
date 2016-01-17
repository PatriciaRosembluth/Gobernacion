class ChangeNameFromDocument < ActiveRecord::Migration
  def change
    rename_column :documents, :name, :typename
  end
end
