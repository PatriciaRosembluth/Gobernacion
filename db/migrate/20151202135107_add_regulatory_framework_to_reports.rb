class AddRegulatoryFrameworkToReports < ActiveRecord::Migration
  def change
    add_column :reports, :regulatory_framework, :text
  end
end
