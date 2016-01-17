class ProceduresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_procedure, only: [:show, :edit, :update, :destroy]
  before_action :verify_password_change

  def index
    @role_current_user = current_user.role
      if  @role_current_user == 1 || @role_current_user == 2 || @role_current_user == 4
        if params[:search]
          @procedures = Procedure.joins(:project).search(params[:search])
        else
          @procedures = Procedure.all#.order('created_at DESC')
        end
      elsif @role_current_user == 3
        @procedures = current_user.person.legal_agent.procedures
      else
        @procedures = current_user.procedures
      end
  end

  def begin
    @projects = Project.available_projects_for_procedure.reverse
    @procedure_types = ProcedureType.get_ones_with_documents
  end

  def new
    @reception_documents = ProcedureType.find(params[:procedure_type_id]).documents
    @project = Project.find(params[:project_id])
    @legal_agents = @project.company.legal_agents
    @procedure_type= ProcedureType.find(params[:procedure_type_id])
  end

  def show
  end

  def assign
    @role_current_user = current_user.role
      if  @role_current_user == 1 || @role_current_user == 4
        @procedures = Procedure.where(state:1)
        @users = User.where(role:5)
      else
        redirect_to root_url
      end
  end

  def send_to_chief
    @procedure = Procedure.find(params[:id])
    @procedure.state = 3
    @procedure.save
    redirect_to @procedure
  end

  def finish
    @procedure = Procedure.find(params[:id])
    @procedure.end_date = Date.today
    if params[:finished]=='yes'
      @procedure.state=4
    elsif params[:finished]=='no'
      @procedure.state=5
    end
    @procedure.save
    redirect_to @procedure
  end

  def show
  end

  def edit
    @role_current_user = current_user.role
      if @role_current_user == 5 || @role_current_user == 3 || @role_current_user == 1
        if params[:search]
          @procedures = Procedure.joins(:project).where(user_id: current_user.id ).search(params[:search])
        else
          @procedures= Procedure.joins(:project).where(user_id: current_user.id )
        end
      end
  end

  def create
    @procedure = Procedure.new(procedure_params)
    @procedure.state = 1
    @procedure.start_date = Time.now
    respond_to do |format|
      if @procedure.save
         @procedure_type = ProcedureType.find(params[:procedure][:procedure_type_id])
         @procedure_type.documents.each do |document|
           @received_document = ReceivedDocument.create(procedure_id:@procedure.id,document_id:document.id,reference:params[document.typename])
           @received_document.create_verified_lists
         end
        # @doc_reception_list = @procedure_type.get_doc_reception_verif_list
        # @verified_list = VerifiedList.create_verified_list(@doc_reception_list.id ,@procedure.id)
        format.html { redirect_to @procedure , notice: 'Tramite registrado exitosamente' }
        format.json { render :show, status: :created, location: @procedure }
      else
        format.html { render :new }
        format.json { render json: @procedure.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @procedure.update(procedure_params)
        format.html { redirect_to @procedure, notice: 'Tramite actualizado exitosamente' }
        format.json { render :index}
      end
    end
  end

  def destroy
    @procedure.destroy
    respond_to do |format|
      format.html { redirect_to procedures_url, notice: 'Tramite eliminado' }
      format.json { head :no_content }
    end
  end


  private
    def set_procedure
      @procedure = Procedure.find(params[:id])
    end

    def procedure_params
      params.require(:procedure).permit(:project_id,:user_id,:state,:procedure_type_id,:legal_agent_id)
    end
end
