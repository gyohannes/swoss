class Ward < ApplicationRecord
  belongs_to :hospital
  has_many :beds

  validates :name, presence: true

  def to_s
    name
  end

end
