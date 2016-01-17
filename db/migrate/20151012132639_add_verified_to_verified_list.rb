class AddVerifiedToVerifiedList < ActiveRecord::Migration
  def change
    add_column :verified_lists, :verified, :boolean
  end
end
