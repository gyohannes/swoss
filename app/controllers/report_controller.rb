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
    @from_gr = Services::EthioGregorianDates.eth_month_reporting_start(@from) + 5.days
    @to_gr = Services::EthioGregorianDates.eth_month_reporting_end(@to)
    @date_range = (@from_gr..@to_gr).uniq{|x| [x.month, x.year]}

    render partial: 'surgical_service_efficiency'
  end

  def surgical_efficiency
  end
end
