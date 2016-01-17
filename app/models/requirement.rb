class Requirement < ActiveRecord::Base
  belongs_to :document
  belongs_to :procedure_type

  def self.delete_null_fields
    Requirement.destroy_all(document_id: nil)
    Requirement.destroy_all(procedure_type: nil)
  end

end
