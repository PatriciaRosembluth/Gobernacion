class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :verify_password_change

  def index
      if user_signed_in?
          @role_current_user = current_user.role
        puts current_user.role
        if    @role_current_user==2 ||   @role_current_user==4 ||   @role_current_user==1 || @role_current_user==5
           @projects = Project.all
              if params[:search]
                @projects = Project.search(params[:search]).order("created_at DESC")
              else
                @projects = Project.all.order('created_at ASC')
              end

        elsif    @role_current_user==3

          @legal_agent_company_id =  current_user.person.legal_agent

            if @legal_agent_company_id!=nil
                @legal_agent_company_id =  current_user.person.legal_agent.company_id
            end
            @projects= Project.where(company_id: @legal_agent_company_id )
         elsif   @role_current_user!=2 ||  @role_current_user!=4 ||   @role_current_user!=1 ||    @role_current_user!=3
           redirect_to root_url
        end
      @projects
     end
  end
  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
      if current_user.role==2 ||current_user.role==1
        @project = Project.new
        @companies = Company.get_companies_with_legal_agents
      else
        redirect_to root_url
      end
end
  # GET /projects/1/edit
  def edit
      if current_user.role==2 ||current_user.role==1
      @companies = Array.new
      Company.all.each do |comp|
        @companies << [comp.name, comp.id]
        end
      else
        redirect_to root_url
      end
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @companies = Array.new
    @project.name = @project.name.upcase
    Company.all.each do |comp|
      @companies << [comp.name, comp.id]
    end
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Proyecto registrado exitosamente.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    @companies = Array.new
    Company.all.each do |comp|
      @companies << [comp.name, comp.id]
    end
    @project.name = @project.name.upcase
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Proyecto actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Proyecto eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :description, :address, :zone, :latitude, :longitude, :company_id)
    end
end
