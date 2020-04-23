class OrSchedulesController < ApplicationController
  before_action :set_or_schedule, only: [:show, :edit, :update, :destroy]

  # GET /or_schedules
  # GET /or_schedules.json
  def index
    @or_schedules = OrSchedule.all
    @patients = []
  end

  def today
    @or_schedules = OrSchedule.where('scheduled_date_gr = ?', Date.today)
  end

  def load_patients
    @admissions = Admission.joins(:patient).where('mrn = ?', params[:mrn]).where('status in (?)', [Constants::ON_WAITING_LIST,Constants::ADMITTED])
    render partial: 'patients'
  end

  def load_sub_form
    @procedure_type = params[:procedure_type]
    render partial: 'procedure_sub_form'
  end

  # GET /or_schedules/1
  # GET /or_schedules/1.json
  def show
  end

  # GET /or_schedules/new
  def new
    @or_schedule = OrSchedule.new
    @or_schedule.user_id = current_user.id
    @or_schedule.admission_id = params[:admission]
  end

  # GET /or_schedules/1/edit
  def edit
    @procedure_type = @or_schedule.procedure_type
  end

  # POST /or_schedules
  # POST /or_schedules.json
  def create
    @or_schedule = OrSchedule.new(or_schedule_params)
    @procedure_type = @or_schedule.procedure_type
    respond_to do |format|
      if @or_schedule.save
        format.html { redirect_to or_schedules_url, notice: 'Or schedule was successfully created.' }
        format.json { render :show, status: :created, location: @or_schedule }
      else
        format.html { render :new }
        format.json { render json: @or_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /or_schedules/1
  # PATCH/PUT /or_schedules/1.json
  def update
    @procedure_type = or_schedule_params[:procedure_type]
    respond_to do |format|
      if @or_schedule.update(or_schedule_params)
        format.html { redirect_to or_schedules_url, notice: 'Or schedule was successfully updated.' }
        format.json { render :show, status: :ok, location: @or_schedule }
      else
        format.html { render :edit }
        format.json { render json: @or_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /or_schedules/1
  # DELETE /or_schedules/1.json
  def destroy
    @or_schedule.destroy
    respond_to do |format|
      format.html { redirect_to or_schedules_url, notice: 'Or schedule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_or_schedule
      @or_schedule = OrSchedule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def or_schedule_params
      params.require(:or_schedule).permit(:user_id, :admission_id, :procedure_type, :surgeon_id, :anesthesian_id, :scrub_nurse_id, :circulating_nurse_id, :scheduled_date, :scheduled_time, :schedule_order_id)
    end
end
