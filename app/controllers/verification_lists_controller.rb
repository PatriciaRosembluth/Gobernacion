class VerificationListsController < ApplicationController
  before_action :set_verification_list, only: [:show, :edit, :update, :destroy]
  before_action :verify_password_change
  before_action :verify_role
  # GET /verification_lists
  # GET /verification_lists.json
  def index
    if params[:search]
      @verification_lists = VerificationList.search(params[:search]).order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    else
      @verification_lists = VerificationList.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    end
  end

  # GET /verification_lists/1
  # GET /verification_lists/1.json
  def show
    @count = @verification_list.verification_fields.count
    VerificationField.delete_null_fields
  end

  # GET /verification_lists/new
  def new
    @verification_list = VerificationList.new
  end

  # GET /verification_lists/1/edit
  def edit
    @count = @verification_list.verification_fields.count
  end

  # POST /verification_lists
  # POST /verification_lists.json
  def create
    @verification_list = VerificationList.new(verification_list_params)
    @verification_list.name = @verification_list.name.upcase
    respond_to do |format|
      if @verification_list.save
        format.html { redirect_to @verification_list, notice: 'Lista de verificacion creada exitosamente.' }
        format.json { render :show, status: :created, location: @verification_list }
      else
        format.html { render :new }
        format.json { render json: @verification_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /verification_lists/1
  # PATCH/PUT /verification_lists/1.json
  def update
    @count = @verification_list.verification_fields.count
    respond_to do |format|
      if @verification_list.update(verification_list_params)
        format.html { redirect_to @verification_list, notice: 'Lista de verificacion actualizada exitosamente.' }
        format.json { render :show, status: :ok, location: @verification_list }
      else
        format.html { render :edit }
        format.json { render json: @verification_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /verification_lists/1
  # DELETE /verification_lists/1.json
  def destroy
    @verification_list.destroy
    respond_to do |format|
      format.html { redirect_to verification_lists_url, notice: 'Lista de verificacion eliminada exitosamente.' }
      format.json { head :no_content }
    end
  end
  def verify_role
  if user_signed_in?
    if current_user.role==1
      [ :edit, :index, :new, :show]

    else
      redirect_to root_url
    end
   end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_verification_list
      @verification_list = VerificationList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def verification_list_params
      params.require(:verification_list).permit!
    end
end
