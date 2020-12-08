class SurgeonsController < ApplicationController
  before_action :set_surgeon, only: [:show, :edit, :update, :destroy]

  # GET /surgeons
  # GET /surgeons.json
  def index
    @surgeons = Surgeon.all
  end

  # GET /surgeons/1
  # GET /surgeons/1.json
  def show
  end

  # GET /surgeons/new
  def new
    @surgeon = Surgeon.new
  end

  # GET /surgeons/1/edit
  def edit
  end

  # POST /surgeons
  # POST /surgeons.json
  def create
    @surgeon = Surgeon.new(surgeon_params)

    respond_to do |format|
      if @surgeon.save
        format.html { redirect_to surgeons_path, notice: 'Surgeon was successfully created.' }
        format.json { render :show, status: :created, location: @surgeon }
      else
        format.html { render :new }
        format.json { render json: @surgeon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /surgeons/1
  # PATCH/PUT /surgeons/1.json
  def update
    respond_to do |format|
      if @surgeon.update(surgeon_params)
        format.html { redirect_to surgeons_path, notice: 'Surgeon was successfully updated.' }
        format.json { render :show, status: :ok, location: @surgeon }
      else
        format.html { render :edit }
        format.json { render json: @surgeon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /surgeons/1
  # DELETE /surgeons/1.json
  def destroy
    @surgeon.destroy
    respond_to do |format|
      format.html { redirect_to surgeons_url, notice: 'Surgeon was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_surgeon
      @surgeon = Surgeon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def surgeon_params
      params.require(:surgeon).permit(:name, :occupation_group_id, :hospital_id)
    end
end
