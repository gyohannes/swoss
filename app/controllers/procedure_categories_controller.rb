class ProcedureCategoriesController < ApplicationController
  before_action :set_procedure_category, only: [:show, :edit, :update, :destroy]

  # GET /procedure_categories
  # GET /procedure_categories.json
  def index
    @procedure_categories = ProcedureCategory.all
  end

  # GET /procedure_categories/1
  # GET /procedure_categories/1.json
  def show
  end

  # GET /procedure_categories/new
  def new
    @procedure_category = ProcedureCategory.new
  end

  # GET /procedure_categories/1/edit
  def edit
  end

  # POST /procedure_categories
  # POST /procedure_categories.json
  def create
    @procedure_category = ProcedureCategory.new(procedure_category_params)

    respond_to do |format|
      if @procedure_category.save
        format.html { redirect_to procedure_categories_path, notice: 'Procedure category was successfully created.' }
        format.json { render :show, status: :created, location: @procedure_category }
      else
        format.html { render :new }
        format.json { render json: @procedure_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /procedure_categories/1
  # PATCH/PUT /procedure_categories/1.json
  def update
    respond_to do |format|
      if @procedure_category.update(procedure_category_params)
        format.html { redirect_to procedure_categories_path, notice: 'Procedure category was successfully updated.' }
        format.json { render :show, status: :ok, location: @procedure_category }
      else
        format.html { render :edit }
        format.json { render json: @procedure_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /procedure_categories/1
  # DELETE /procedure_categories/1.json
  def destroy
    @procedure_category.destroy
    respond_to do |format|
      format.html { redirect_to procedure_categories_url, notice: 'Procedure category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_procedure_category
      @procedure_category = ProcedureCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def procedure_category_params
      params.require(:procedure_category).permit(:code, :max_appointment_days, :max_postponment_days)
    end
end
