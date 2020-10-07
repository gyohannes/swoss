class Hospital < ApplicationRecord
  belongs_to :administration_unit
  has_many :patients

  def to_s
    name
  end
end
