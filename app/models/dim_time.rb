class DimTime < ApplicationRecord
  validates :period, :year, :month, :month_str, presence: true

  before_validation(on: :create) do
    self.month_str = case month
    when 1
      "#{year} Ene"
    when 2
      "#{year} Feb"
    when 3
      "#{year} Mar"
    when 4
      "#{year} Abr"
    when 5
      "#{year} May"
    when 6
      "#{year} Jun"
    when 7
      "#{year} Jul"
    when 8
      "#{year} Ago"
    when 9
      "#{year} Sep"
    when 10
      "#{year} Oct"
    when 11
      "#{year} Nov"
    else
      "#{year} Dic"
    end
    self.period = "#{year}#{month.to_s.rjust(2, '0')}"
  end
end
