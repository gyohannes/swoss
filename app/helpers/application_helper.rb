module ApplicationHelper
  def boolean_to_text(bool)
    bool == true ? 'Yes' : 'No'
  end

  def set_age(eth_date)
    ethdate = eth_date.split('/')
    dob = fromEthiopicToGregorian(ethdate[2].to_i, ethdate[1].to_i, ethdate[0].to_i)
    total = (Date.today - dob).to_i
    years = total > 0 ? total/365 : 0
    total = total > 0 ? total%365 : 0
    months = total > 0 ? total/30 : 0
    days = total > 0 ? total%30 + 1 : 0
    return "#{years > 0 ? years.to_s + " Years " : ''} #{(months > 0 and years == 0) ? months.to_s + " Months " : ''} #{(days > 0 and years == 0 and months == 0) ? days.to_s + " Days " : ''}"
  end

end
