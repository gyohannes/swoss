class OccupationGroupsController < ApplicationController
  before_action :set_occupation_group, only: [:show, :edit, :update, :destroy]

  # GET /occupation_groups
  # GET /occupation_groups.json
  def index
    @occupation_groups = OccupationGroup.all
  end

  # GET /occupation_groups/1
  # GET /occupation_groups/1.json
  def show
  end

  # GET /occupation_groups/new
  def new
    @occupation_group = OccupationGroup.new
  end

  # GET /occupation_groups/1/edit
  def edit
  end

  # POST /occupation_groups
  # POST /occupation_groups.json
  def create
    @occupation_group = OccupationGroup.new(occupation_group_params)

    respond_to do |format|
      if @occupation_group.save
        format.html { redirect_to occupation_groups_path, notice: 'Occupation group was successfully created.' }
        format.json { render :show, status: :created, location: @occupation_group }
      else
        format.html { render :new }
        format.json { render json: @occupation_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /occupation_groups/1
  # PATCH/PUT /occupation_groups/1.json
  def update
    respond_to do |format|
      if @occupation_group.update(occupation_group_params)
        format.html { redirect_to occupation_groups_path, notice: 'Occupation group was successfully updated.' }
        format.json { render :show, status: :ok, location: @occupation_group }
      else
        format.html { render :edit }
        format.json { render json: @occupation_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /occupation_groups/1
  # DELETE /occupation_groups/1.json
  def destroy
    @occupation_group.destroy
    respond_to do |format|
      format.html { redirect_to occupation_groups_url, notice: 'Occupation group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_occupation_group
      @occupation_group = OccupationGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def occupation_group_params
      params.require(:occupation_group).permit(:name)
    end
end
