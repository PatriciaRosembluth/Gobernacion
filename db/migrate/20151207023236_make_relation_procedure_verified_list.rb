class MakeRelationProcedureVerifiedList < ActiveRecord::Migration
  def change
    remove_column :verified_lists, :procedure_id
  end
end
