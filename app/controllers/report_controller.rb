class ReportController < ApplicationController
  def backlog
  end

  def waitlist
  end

  def surgical_service
  end

  def load_surgical_service
    @from = params[:from]
    @to = params[:to]
    @from_gr = Services::EthioGregorianDates.eth_month_reporting_start(@from)
    @to_gr = Services::EthioGregorianDates.eth_month_reporting_end(@to)

    render partial: 'surgical_service'
  end

  def surgical_service_efficiency
  end

  def load_surgical_service_efficiency
    @from = params[:from]
    @to = params[:to]
    @from_gr = Services::EthioGregorianDates.eth_month_reporting_start(@from) + 1.month
    @to_gr = Services::EthioGregorianDates.eth_month_reporting_end(@to)
    @date_range = (@from_gr..@to_gr).uniq{|x| [x.month, x.year]}.collect{|y| y.change(day: 15)}

    render partial: 'surgical_service_efficiency'
  end

  def surgical_efficiency
  end

  def custom_report
    @admissions = []
  end

  def load_admissions
    from_gr = Services::EthioGregorianDates.eth_month_reporting_start(params[:from])
    to_gr = Services::EthioGregorianDates.eth_month_reporting_end(params[:to])
    @admissions = Admission.admissions(from_gr, to_gr)
    render partial: 'custom_report'
  end
end
