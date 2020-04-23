module Services
  class EthioGregorianDates
    def self.set_gregorian(ethiopian_date, separator)
      unless ethiopian_date.blank?
        year_month_day = ethiopian_date.split(separator)
        day = year_month_day[0].to_i
        month = year_month_day[1].to_i
        year = year_month_day[2].to_i
        return fromEthiopicToGregorian(year, month, day)
      end
    end

    def self.set_ethiopian(gregorian_date, separator)
      unless gregorian_date.blank?
        year_month_day = gregorian_date.split(separator)
        year = year_month_day[0].to_i
        month = year_month_day[1].to_i
        day = year_month_day[2].to_i
        return fromGregorianToEthiopic(year, month, day)
      end
    end

    def self.eth_month_reporting_start(ethiopian_month)
      month_year = ethiopian_month.split('/')
      month, year = month_year[0].to_i, month_year[1].to_i
      eth_date = '21/' + (month > 1 ? month - 1 : '12').to_s + '/' + (month > 1 ? year : year - 1).to_s
      return set_gregorian(eth_date, '/')
    end

    def self.eth_month_reporting_end(ethiopian_month)
      month_year = ethiopian_month.split('/')
      month, year = month_year[0].to_i, month_year[1].to_i
      eth_date = '20/' + month.to_s + '/' + year.to_s
      return set_gregorian(eth_date, '/')
    end

  end
end