class AdministrationUnitsController < ApplicationController
  before_action :set_administration_unit, only: [:show, :edit, :update, :destroy]
  before_action :set_parent
  # GET /administration_units
  # GET /administration_units.json
  def index
    @administration_units = AdministrationUnit.top_administration_unit ? AdministrationUnit.top_administration_unit.sub_administration_units + [AdministrationUnit.top_administration_unit] : []
  end

  def load_tree
    render json: AdministrationUnit.administration_tree
  end

  def load_sub_units
    @parent  = AdministrationUnit.find(params[:node])
    @administration_units = @parent.sub_administration_units
    render partial: 'administration_units'
  end
  # GET /administration_units/1
  # GET /administration_units/1.json
  def show
  end

  # GET /administration_units/new
  def new
    @administration_unit = AdministrationUnit.new
  end

  # GET /administration_units/1/edit
  def edit
  end

  # POST /administration_units
  # POST /administration_units.json
  def create
    @administration_unit = AdministrationUnit.new(administration_unit_params)

    respond_to do |format|
      if @administration_unit.save
        format.html { redirect_to administration_units_url, notice: 'Administration unit was successfully created.' }
        format.json { render :show, status: :created, location: @administration_unit }
      else
        format.html { render :new }
        format.json { render json: @administration_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /administration_units/1
  # PATCH/PUT /administration_units/1.json
  def update
    respond_to do |format|
      if @administration_unit.update(administration_unit_params)
        format.html { redirect_to administration_units_url, notice: 'Administration unit was successfully updated.' }
        format.json { render :show, status: :ok, location: @administration_unit }
      else
        format.html { render :edit }
        format.json { render json: @administration_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administration_units/1
  # DELETE /administration_units/1.json
  def destroy
    @administration_unit.destroy
    respond_to do |format|
      format.html { redirect_to administration_units_url, notice: 'Administration unit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_administration_unit
      @administration_unit = AdministrationUnit.find(params[:id])
    end

    def set_parent
      @parent = AdministrationUnit.find_by(id: params[:parent])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def administration_unit_params
      params.require(:administration_unit).permit(:name, :category, :parent_administration_unit_id, :status)
    end
end
