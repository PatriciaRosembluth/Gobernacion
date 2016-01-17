class VerificationField < ActiveRecord::Base
  belongs_to :verification_list

  def self.delete_null_fields
    VerificationField.destroy_all("description=''")
  end
end
