class Region < ApplicationRecord
  has_many :patients

  def current_status
    status == true ? 'Active' : 'Inactive'
  end

  def to_s
    name
  end

end
