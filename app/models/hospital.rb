class Hospital < ApplicationRecord
  belongs_to :region, optional: true
  has_many :patients

  def to_s
    name
  end
end
