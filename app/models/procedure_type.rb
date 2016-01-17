class ProcedureType < ActiveRecord::Base
  has_many :procedures, :dependent => :destroy

  has_many :documents, :through => :requirements
  has_many :requirements, :dependent => :destroy
  before_validation :uppercase
  accepts_nested_attributes_for :requirements

  validates :name, presence: { :message => 'no debe dejarse en blanco' }
  validates :name, uniqueness: { :message => 'ya fue registrado, no puede repetirse' }
  validates :name, length: {minimum: 5, :message => 'no debe tener menos de 5 caracteres.'}
  validates :name, length: {maximum: 100, :message => 'no debe tener mas de 100 caracteres.'}

  def get_doc_reception_verif_list
    verification_lists.each do |verification_list|
      if verification_list.list_category_id == 1
        return verification_list
      end
    end
    verification_lists.first
  end

  def self.search(search)
    where("name LIKE ?", "%#{search}%")
  end

  def self.get_ones_with_documents
    @procedure_types = Array.new
    ProcedureType.all.each do |procedure_type|
      if procedure_type.documents.count>0
        @procedure_types << procedure_type
      end
    end
    @procedure_types
  end
  protected
  def uppercase
    self.name = self.name.upcase
  end 
end
