class CreateVerifiedLists < ActiveRecord::Migration
  def change
    create_table :verified_lists do |t|
      t.references :verification_list, index: true, foreign_key: true
      t.references :employee, index: true, foreign_key: true
      t.datetime :date_of_verification

      t.timestamps null: false
    end
  end
end
