class RemoveProcedureTypeFromVerificationLists < ActiveRecord::Migration
  def change
    remove_column :verification_lists, :procedure_type_id
  end
end
