class OrTablesController < ApplicationController
  before_action :set_or_table, only: [:show, :edit, :update, :destroy]

  # GET /or_tables
  # GET /or_tables.json
  def index
    @or_tables = OrTable.all
  end

  # GET /or_tables/1
  # GET /or_tables/1.json
  def show
  end

  # GET /or_tables/new
  def new
    @or_table = OrTable.new
  end

  # GET /or_tables/1/edit
  def edit
  end

  # POST /or_tables
  # POST /or_tables.json
  def create
    @or_table = OrTable.new(or_table_params)

    respond_to do |format|
      if @or_table.save
        format.html { redirect_to or_tables_path, notice: 'Or table was successfully created.' }
        format.json { render :show, status: :created, location: @or_table }
      else
        format.html { render :new }
        format.json { render json: @or_table.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /or_tables/1
  # PATCH/PUT /or_tables/1.json
  def update
    respond_to do |format|
      if @or_table.update(or_table_params)
        format.html { redirect_to or_tables_path, notice: 'Or table was successfully updated.' }
        format.json { render :show, status: :ok, location: @or_table }
      else
        format.html { render :edit }
        format.json { render json: @or_table.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /or_tables/1
  # DELETE /or_tables/1.json
  def destroy
    @or_table.destroy
    respond_to do |format|
      format.html { redirect_to or_tables_url, notice: 'Or table was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_or_table
      @or_table = OrTable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def or_table_params
      params.require(:or_table).permit(:name, :code, :or_block_id)
    end
end
