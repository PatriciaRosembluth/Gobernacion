class ChangeColumnFromVerifiedField < ActiveRecord::Migration
  def change
    rename_column :verified_fields, :verification_list_id, :verified_list_id
  end
end
