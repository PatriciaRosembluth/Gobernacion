class ChangeReferenceName < ActiveRecord::Migration
  def change
    remove_index :reports, column: :Procedure_id
    rename_column :reports, :Procedure_id, :procedure_id
    add_index :reports, :procedure_id

  end
end
