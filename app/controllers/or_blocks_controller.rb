class OrBlocksController < ApplicationController
  before_action :set_or_block, only: [:show, :edit, :update, :destroy]

  # GET /or_blocks
  # GET /or_blocks.json
  def index
    @or_blocks = OrBlock.all
  end

  # GET /or_blocks/1
  # GET /or_blocks/1.json
  def show
  end

  # GET /or_blocks/new
  def new
    @or_block = OrBlock.new
    @or_block.hospital_id = current_user.hospital_id
  end

  # GET /or_blocks/1/edit
  def edit
  end

  # POST /or_blocks
  # POST /or_blocks.json
  def create
    @or_block = OrBlock.new(or_block_params)

    respond_to do |format|
      if @or_block.save
        format.html { redirect_to or_blocks_url, notice: 'OR block was successfully created.' }
        format.json { render :show, status: :created, location: @or_block }
      else
        format.html { render :new }
        format.json { render json: @or_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /or_blocks/1
  # PATCH/PUT /or_blocks/1.json
  def update
    respond_to do |format|
      if @or_block.update(or_block_params)
        format.html { redirect_to or_blocks_url, notice: 'OR block was successfully updated.' }
        format.json { render :show, status: :ok, location: @or_block }
      else
        format.html { render :edit }
        format.json { render json: @or_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /or_blocks/1
  # DELETE /or_blocks/1.json
  def destroy
    @or_block.destroy
    respond_to do |format|
      format.html { redirect_to or_blocks_url, notice: 'OR block was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_or_block
      @or_block = OrBlock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def or_block_params
      params.require(:or_block).permit(:name, :hospital_id)
    end
end
