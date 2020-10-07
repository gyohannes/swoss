class OrTable < ApplicationRecord
  belongs_to :or_block

  def to_s
    name
  end

  def block_and_name
    [or_block, name].join(" - ")
  end

end
