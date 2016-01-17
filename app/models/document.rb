class Document < ActiveRecord::Base
  has_many :procedure_types, :through => :requirements
  has_many :requirements, :dependent => :destroy

  has_many :verification_lists, :through => :revisions
  has_many :revisions, :dependent => :destroy

  has_many :received_documents, :dependent => :destroy

  accepts_nested_attributes_for :revisions, :reject_if => :all_blank, :allow_destroy => true
  before_validation :uppercase
  validates :typename, presence: {message:'no debe dejarse en blanco'}
  validates :typename, uniqueness: {message: 'ya existe, no se debe repetir'}

  def self.search(search)
    where("typename LIKE :search ", search:"%#{search}%")
  end
protected
def uppercase
  self.typename = self.typename.upcase
end  
end
