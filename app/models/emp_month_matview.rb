class EmpMonthMatview < ActiveRecord::Base
  self.table_name = 'emp_month_matview'

  SECTORS = {
    '' => 'Todos los sectores',
    '1' => 'Sector público',
    '0' => 'Sector privado'
  }

  INSTITUTIONS = {
    '1' => 'Ministerios',
    '2' => 'Autónomas',
    '3' => 'Instituciones descentralizadas',
    '4' => 'Instituciones financieras',
    '5' => 'Alcaldías',
    '6' => 'Instituciones independientes al órgano ejecutivo'
  }

  AREAS = {
    '1' => 'Salud',
    '2' => 'Educación',
    '3' => 'Fuerza armada',
    '4' => 'Seguridad',
    '5' => 'Económico',
    '6' => 'Agricultura',
    '7' => 'Medio ambiente',
    '8' => 'Turismo',
    '9' => 'Obra pública',
    '10' => 'Financiera',
    '11' => 'Transporte',
    '12' => 'Recreación',
    '13' => 'Desarrollo territorial',
    '14' => 'Otras'
  }

  MINISTRIES = {
    '1' => 'Ministerio de agricultura y ganadería',
    '2' => 'Ministerio de economía',
    '3' => 'Ministerio de educación',
    '4' => 'Ministerio de gobernación y desarrollo territorial',
    '5' => 'Ministerio de hacienda',
    '6' => 'Ministerio de justicia y seguridad pública',
    '7' => 'Ministerio de la defensa nacional',
    '8' => 'Ministerio de medio ambiente y recursos naturales',
    '9' => 'Ministerio de obras públicas',
    '10' => 'Ministerio de relaciones exteriores',
    '11' => 'Ministerio de salud',
    '12' => 'Ministerio de trabajo y previsión social',
    '13' => 'Ministerio de turismo',
    '14' => 'Presidencia',
    '15' => 'Instituciones cerradas',
    '16' => 'No depende de ministerios'
  }

  TIMES = {
    '1' => 'Promedio anual',
    '2' => 'Anual',
    '3' => 'Promedio mensual',
    '4' => 'Mensual'
  }

  GROUP_BY = {
    '0' => 'Sector',
    '1' => 'Instituciones públicas',
    '2' => 'Áreas de gestión',
    '3' => 'Ministerios'
  }

  GROUP_BY_FIELD = {
    '1' => 'class_a',
    '2' => 'class_b',
    '3' => 'class_c'
  }

  def readonly?
    true
  end

  def self.refresh
    ActiveRecord::Base.connection.execute('REFRESH MATERIALIZED VIEW emp_month_matview')
  end
end
