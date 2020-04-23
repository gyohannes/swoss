class ScheduleOrdersController < ApplicationController
  before_action :set_schedule_order, only: [:show, :edit, :update, :destroy]

  # GET /schedule_orders
  # GET /schedule_orders.json
  def index
    @schedule_orders = ScheduleOrder.all
  end

  # GET /schedule_orders/1
  # GET /schedule_orders/1.json
  def show
  end

  # GET /schedule_orders/new
  def new
    @schedule_order = ScheduleOrder.new
  end

  # GET /schedule_orders/1/edit
  def edit
  end

  # POST /schedule_orders
  # POST /schedule_orders.json
  def create
    @schedule_order = ScheduleOrder.new(schedule_order_params)

    respond_to do |format|
      if @schedule_order.save
        format.html { redirect_to schedule_orders_path, notice: 'Schedule order was successfully created.' }
        format.json { render :show, status: :created, location: @schedule_order }
      else
        format.html { render :new }
        format.json { render json: @schedule_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schedule_orders/1
  # PATCH/PUT /schedule_orders/1.json
  def update
    respond_to do |format|
      if @schedule_order.update(schedule_order_params)
        format.html { redirect_to schedule_orders_path, notice: 'Schedule order was successfully updated.' }
        format.json { render :show, status: :ok, location: @schedule_order }
      else
        format.html { render :edit }
        format.json { render json: @schedule_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schedule_orders/1
  # DELETE /schedule_orders/1.json
  def destroy
    @schedule_order.destroy
    respond_to do |format|
      format.html { redirect_to schedule_orders_url, notice: 'Schedule order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule_order
      @schedule_order = ScheduleOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def schedule_order_params
      params.require(:schedule_order).permit(:name)
    end
end
