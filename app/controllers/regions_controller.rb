class RegionsController < ApplicationController
  before_action :set_region, only: [:show, :edit, :update, :destroy]
  # GET /administration_units
  # GET /administration_units.json
  def index
    @regions = Region.all
  end

  # GET /administration_units/1
  # GET /administration_units/1.json
  def show
  end

  # GET /administration_units/new
  def new
    @region = Region.new
  end

  # GET /administration_units/1/edit
  def edit
  end

  # POST /administration_units
  # POST /administration_units.json
  def create
    @region = Region.new(region_params)

    respond_to do |format|
      if @region.save
        format.html { redirect_to regions_url, notice: 'Region unit was successfully created.' }
        format.json { render :show, status: :created, location: @region }
      else
        logger.info("------------------------#{@region.errors.inspect}")
        format.html { render :new }
        format.json { render json: @region.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /administration_units/1
  # PATCH/PUT /administration_units/1.json
  def update
    respond_to do |format|
      if @region.update(region_params)
        format.html { redirect_to regions_url, notice: 'Region unit was successfully updated.' }
        format.json { render :show, status: :ok, location: @region }
      else
        format.html { render :edit }
        format.json { render json: @region.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administration_units/1
  # DELETE /administration_units/1.json
  def destroy
    @region.destroy
    respond_to do |format|
      format.html { redirect_to regions_url, notice: 'Region unit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_administration_unit
      @region = Region.find(params[:id])
    end

    def set_region
      @region = Region.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def region_params
      params.require(:region).permit(:name, :status)
    end
end
