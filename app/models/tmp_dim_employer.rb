class TmpDimEmployer < ApplicationRecord
  validates :nit, :name, presence: true

  def text
    name
  end
end