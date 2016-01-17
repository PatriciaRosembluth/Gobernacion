class CreateListCategories < ActiveRecord::Migration
  def change
    create_table :list_categories do |t|
      t.string :name

      t.timestamps null: false
    end

    remove_column :verification_lists, :category
    add_reference :verification_lists, :list_category

  end
end
