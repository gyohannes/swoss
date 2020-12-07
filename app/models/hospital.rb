class Hospital < ApplicationRecord
  belongs_to :region
  has_many :patients

  def to_s
    name
  end
end
