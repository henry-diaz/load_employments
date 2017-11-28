class TmpFactEmployment < ApplicationRecord
  # belongs_to :dim_employer
  # belongs_to :dim_time

  # validates :dim_employer_id, :dim_time_id, :total, :amount, presence: true
  # validates :total, :amount, :up, :up_amount, :down, :down_amount, :pensioned, numericality: { greater_than_or_equal_to: 0 }
end
