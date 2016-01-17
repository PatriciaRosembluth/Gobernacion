class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :principal_activity
      t.integer :nit
      t.string :address
      t.string :canton
      t.string :province
      t.string :departament
      t.string :phones
      t.string :fax
      t.string :mailbox

      t.timestamps null: false
    end
  end
end
