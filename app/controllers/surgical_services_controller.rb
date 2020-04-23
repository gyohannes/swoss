class SurgicalServicesController < ApplicationController
  before_action :set_surgical_service, only: [:show, :edit, :update, :destroy]

  # GET /surgical_services
  # GET /surgical_services.json
  def index
    @surgical_services = SurgicalService.all
    @or_schedules = OrSchedule.all
  end

  def load_sub_form
    @status = params[:status]
    render partial: 'sub_form'
  end

  def load_death_reason
    @outcome = params[:outcome]
    render partial: 'death_reason'
  end

  def surgeries_by_status_by_month
    from = Date.today - 12.months
    to = Date.today
    eth_from = fromGregorianToEthiopic(from.year, from.month, from.day).split('-')
    eth_to = fromGregorianToEthiopic(to.year, to.month, to.day).split('-')
    eth_from = eth_from[1] + '/' + eth_from[0]
    eth_to = eth_to[1] + '/' + eth_to[0]
    from_gr = Services::EthioGregorianDates.eth_month_reporting_start(eth_from) + 2.month
    to_gr = Services::EthioGregorianDates.eth_month_reporting_end(eth_to) + 1.month
    date_range = (from_gr..to_gr).uniq{|d| d.month}.collect{|y| y.change(day: 15)}
    surgeries = []
    Constants::POST_SCHEDULE_STATUS.each do |s|
      surgeries << {name: s == Constants::OPERATED ? 'Surgeries' : 'Cancellation',
                    data: date_range.map{|d| [AmharicMonths[fromGregorianToEthiopic(d.year, d.month, d.day).split('-')[1]],
                                              SurgicalService.surgeries_month_total(s,d)]} }
    end
    render json: surgeries
  end

  def surgical_service_efficiency_by_month
    from = Date.today - 11.months
    to = Date.today
    eth_from = fromGregorianToEthiopic(from.year, from.month, from.day).split('-')
    eth_to = fromGregorianToEthiopic(to.year, to.month, to.day).split('-')
    eth_from = eth_from[1] + '/' + eth_from[0]
    eth_to = eth_to[1] + '/' + eth_to[0]
    from_gr = Services::EthioGregorianDates.eth_month_reporting_start(eth_from) + 5.days
    to_gr = Services::EthioGregorianDates.eth_month_reporting_end(eth_to) - 5.days
    date_range = (from_gr..to_gr).uniq{|d| [d.month, d.year]}.collect{|y| y.change(day: 15)}
    efficiencies = []
    ['te', 'se'].each do |s|
      efficiencies << {name: s == 'te' ? 'Surgery/table/day' : 'Surgery/surgeon/day',
                    data: date_range.map{|d| [AmharicMonths[fromGregorianToEthiopic(d.year, d.month, d.day).split('-')[1]],
                                              s=='te' ? SurgicalService.or_table_efficiency(d) : SurgicalService.month_surgeon_efficiency(d) ]} }
    end
    render json: efficiencies
  end

  def average_procedure_duration_by_month
    from = Date.today - 11.months
    to = Date.today
    eth_from = fromGregorianToEthiopic(from.year, from.month, from.day).split('-')
    eth_to = fromGregorianToEthiopic(to.year, to.month, to.day).split('-')
    eth_from = eth_from[1] + '/' + eth_from[0]
    eth_to = eth_to[1] + '/' + eth_to[0]
    from_gr = Services::EthioGregorianDates.eth_month_reporting_start(eth_from) + 5.days
    to_gr = Services::EthioGregorianDates.eth_month_reporting_end(eth_to) - 5.days
    date_range = (from_gr..to_gr).uniq{|d| [d.month, d.year]}.collect{|y| y.change(day: 15)}
    durations = date_range.map{|d| [AmharicMonths[fromGregorianToEthiopic(d.year, d.month, d.day).split('-')[1]],
                                                 SurgicalService.month_average_procedure_duration(d) ]}
    render json: durations
  end

  # GET /surgical_services/1
  # GET /surgical_services/1.json
  def show
  end

  # GET /surgical_services/new
  def new
    @surgical_service = SurgicalService.new
    @surgical_service.user_id = current_user.id
    @surgical_service.or_schedule_id = params[:schedule]
  end

  # GET /surgical_services/1/edit
  def edit
    @status = @surgical_service.post_schedule_status
    @outcome = @surgical_service.immediate_postoperative_outcome
  end

  # POST /surgical_services
  # POST /surgical_services.json
  def create
    @surgical_service = SurgicalService.new(surgical_service_params)
    @status = @surgical_service.post_schedule_status
    @outcome = @surgical_service.immediate_postoperative_outcome
    respond_to do |format|
      if @surgical_service.save
        format.html { redirect_to @surgical_service, notice: 'Surgical service was successfully created.' }
        format.json { render :show, status: :created, location: @surgical_service }
      else
        format.html { render :new }
        format.json { render json: @surgical_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /surgical_services/1
  # PATCH/PUT /surgical_services/1.json
  def update
    @status = surgical_service_params[:post_schedule_status]
    @outcome = surgical_service_params[:immediate_postoperative_outcome]
    respond_to do |format|
      if @surgical_service.update(surgical_service_params)
        format.html { redirect_to @surgical_service, notice: 'Surgical service was successfully updated.' }
        format.json { render :show, status: :ok, location: @surgical_service }
      else
        format.html { render :edit }
        format.json { render json: @surgical_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /surgical_services/1
  # DELETE /surgical_services/1.json
  def destroy
    @surgical_service.destroy
    respond_to do |format|
      format.html { redirect_to surgical_services_url, notice: 'Surgical service was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_surgical_service
      @surgical_service = SurgicalService.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def surgical_service_params
      params.require(:surgical_service).permit(:user_id, :or_schedule_id, :post_schedule_status, :reason_for_cancellation, :or_table_id, :anesthesia_time, :incision_time, :surgery_end_time, :surgical_safety_checklist_completed, :immediate_postoperative_outcome, :reason_for_death)
    end
end
