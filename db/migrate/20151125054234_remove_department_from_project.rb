class RemoveDepartmentFromProject < ActiveRecord::Migration
  def change
    remove_column :projects, :departament
  end
end
