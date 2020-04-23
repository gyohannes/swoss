class Region < ApplicationRecord
  has_many :hospitals

  validates :name, presence: true

  def to_s
    name
  end

end
