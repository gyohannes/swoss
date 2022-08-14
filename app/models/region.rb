class Region < ApplicationRecord
  default_scope {order('name')}
  has_many :patients

  validates :name, presence: true

  def current_status
    status == true ? 'Active' : 'Inactive'
  end

  def to_s
    name
  end

end
