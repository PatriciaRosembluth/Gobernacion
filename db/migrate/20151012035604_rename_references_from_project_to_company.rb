class RenameReferencesFromProjectToCompany < ActiveRecord::Migration
  def change
    rename_column :projects, :companty_id, :company_id
  end
end
