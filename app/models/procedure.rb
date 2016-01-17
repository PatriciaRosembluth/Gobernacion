class Procedure < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  belongs_to :procedure_type
  belongs_to :legal_agent
  has_one :report, :dependent => :destroy
  has_many :received_documents, :dependent=> :destroy


  # ESTADOS
  # 1 inicial
  # 2 en revision
  # 3 revisado
  # 4 aceptado
  # 5 rechazado

  def self.search(search)
    where("name LIKE :search ", search:"%#{search}%")
  end

  def get_documents_verified_list
    nil
  end

#  def is_documents_list_verified?
#    get_documents_verified_list.verified
#  end

  def has_documents_verified_list?
    verified_lists.each do |verified_list|
      if verified_list.verification_list.list_category_id==1
        return true
      end
    end
    false
  end

  def has_verified_lists?
    verified_lists.each do |verified_list|
      if verified_list.verification_list.list_category_id!=1
        return true
      end
    end
  false
  end

  def can_be_sent_to_chief?
    if report
      received_documents.each do |received_documents|
        if not received_documents.has_all_lists_verified?
          return false
        end
      end
      return true
    else
      return false
    end
  end

  def get_first_not_reviewed
    verified_lists.each do |verified_list|
      unless verified_list.verified
        return verified_list
      end
    end
    nil
  end

end
