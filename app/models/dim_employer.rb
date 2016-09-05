class DimEmployer < ApplicationRecord
  validates :nit, :name, presence: true
end
