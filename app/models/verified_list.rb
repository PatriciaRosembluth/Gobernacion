class VerifiedList < ActiveRecord::Base
  belongs_to :verification_list
  belongs_to :employee
  has_many :verified_fields, :dependent => :destroy
  belongs_to :received_document

  accepts_nested_attributes_for :verified_fields#, :reject_if => :all_blank, :allow_destroy => true

  def self.create_verified_list (verif_list_id,rec_document_id)
    @verification_list = VerificationList.find(verif_list_id)
    @verified_list = VerifiedList.create(verification_list_id:verif_list_id,received_document_id:rec_document_id,verified:false)
    @verification_list.create_verified_fields_for(@verified_list.id)
    return @verified_list
  end
end
