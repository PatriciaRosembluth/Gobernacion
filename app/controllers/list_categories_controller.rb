class ListCategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list_category, only: [:show, :edit, :update, :destroy]
  before_action :verify_password_change
  before_action :verify_role

  # GET /list_categories
  # GET /list_categories.json
  def index
    @list_categories = ListCategory.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
  end

  # GET /list_categories/new
  def new
    @list_category = ListCategory.new
  end

  # GET /list_categories/1/edit
  def edit
  end

  # POST /list_categories
  # POST /list_categories.json
  def create
    @list_category = ListCategory.new(list_category_params)

    respond_to do |format|
      if @list_category.save
        format.html { redirect_to list_categories_path, notice: 'Categoria de Lista registrada exitosamente' }
        format.json { render :show, status: :created, location: @list_category }
      else
        format.html { render :new }
        format.json { render json: @list_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /list_categories/1
  # PATCH/PUT /list_categories/1.json
  def update
    respond_to do |format|
      if @list_category.update(list_category_params)
        format.html { redirect_to list_categories_path, notice: 'Categoria de Lista actualizada exitosamente' }
        format.json { render :show, status: :ok, location: @list_category }
      else
        format.html { render :edit }
        format.json { render json: @list_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /list_categories/1
  # DELETE /list_categories/1.json
  def destroy
    @list_category.destroy
    respond_to do |format|
      format.html { redirect_to list_categories_url, notice: 'Categoria de Lista eliminada' }
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
    def set_list_category
      @list_category = ListCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_category_params
      params.require(:list_category).permit(:name)
    end
end
