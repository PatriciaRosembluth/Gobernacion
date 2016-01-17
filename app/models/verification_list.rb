class VerificationList < ActiveRecord::Base
  belongs_to :list_category

  has_many :verification_fields, :dependent => :destroy
  has_many :verified_lists, :dependent => :destroy

  has_many :documents, :through => :revisions
  has_many :revisions, :dependent => :destroy
  before_validation :uppercase
  accepts_nested_attributes_for :verification_fields, :reject_if => :all_blank, :allow_destroy => true


  validates :name, presence: {:message => 'no debe dejarse en blanco.'}
  validates :name, uniqueness: {:message => 'se repitio, por favor utilizar otro.'}

  def self.search(search)
    where('name LIKE :search', search:"%#{search}%")
  end

  def create_verified_fields_for(verified_list_id)
    @verification_fields = self.verification_fields
    @verification_fields.each do |verification_field|
      VerifiedField.create(verified_list_id:verified_list_id,verification_field_id:verification_field.id,answer:false)
    end
  end

  def has_a_verified_list? (receiv_document_id)
    if VerifiedList.where(verification_list_id:self.id,received_document_id:receiv_document_id).count>0
      return true
    else
      return false
    end
  end

  def get_verified_list (receiv_document_id)
    VerifiedList.where(verification_list_id:self.id,received_document_id:receiv_document_id).first
  end
  protected
  def uppercase
    self.name = self.name.upcase
  end 

end
