class Region < ApplicationRecord
  has_many :patients

  validates :name, presence: true

  def current_status
    status == true ? 'Active' : 'Inactive'
  end

  def to_s
    name
  end

end
