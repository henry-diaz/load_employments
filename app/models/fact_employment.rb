class FactEmployment < ApplicationRecord
  validates :dim_employer_id, :dim_time_id, :total, :amount, presence: true
end

=begin
{
  "anyo"=>"2015",
  "mes"=>"05",
  "nit"=>"08131501901012",
  "altasTrabajadores"=>2,
  "altasSalarios"=>520.18,
  "bajasTrabajadores"=>0,
  "bajasSalarios"=>0.0,
  "pensionados"=>0,
  "totalTrabajadores"=>28,
  "salarios"=>7282.52,
  "nombre"=>"ASOCIACION COOPERATIVA DE APROVISIONAMIENTO AHORRO CREDITO COMERCIALIZACION PRODUCCION TRASLADO DE CARGA EL BRILLANTE AMANECER DE RL"
}
=end
