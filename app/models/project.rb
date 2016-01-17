class Project < ActiveRecord::Base
	belongs_to :company
	has_many :procedures, :dependent => :destroy
  before_validation :uppercase
	validates :name, :presence => {:message => ' no debe dejarse en blanco.'}
	validates :name, uniqueness: {message: 'del proyecto ya existe, no se debe duplicar'}
	validates :description, :presence => {:message => ' no debe dejarse en blanco.'}
	validates :address, :presence => {:message => ' no debe dejarse en blanco.'}
	 validates :latitude, :presence => {:message => ' y Longitud deben definirse en el mapa'}
	# validates :latitude, numericality: { message: ' debe ser un numero' }
	# validates :longitude, :presence => {:message => ' Debe seleccionarse una ubicacion en el mapa'}
	# validates :longitude, numericality: { message: ' debe ser un numero' }

	def self.search(search)
		where("name LIKE :search ", search:"%#{search}%")
	end

  def has_a_pending_procedure
    procedures.each do |procedure|
      if procedure.state <= 3
        return true
      end
    end
    false
  end

  def has_an_accepted_procedure
    if procedures.any?
      return procedures.last.state == 4
    end
    false
  end

  def self.available_projects_for_procedure
    @projects = Array.new
    @all = Project.all
    @all.each do |project|
        if not project.has_a_pending_procedure
          @projects << project
        end
    end
    @projects
  end
protected
def uppercase
  self.name = self.name.upcase
end  



end
