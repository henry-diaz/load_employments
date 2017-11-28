class EmpMonthMatview < ActiveRecord::Base
  self.table_name = 'emp_month_matview'

  SECTORS = {
    '' => 'Todos los sectores',
    '1' => 'Sector público',
    '0' => 'Sector privado'
  }

  # INSTITUTIONS = {
  #   '5' => 'Alcaldías',
  #   '2' => 'Autónomas',
  #   '3' => 'Instituciones descentralizadas',
  #   '4' => 'Instituciones financieras',
  #   '6' => 'Instituciones independientes al órgano ejecutivo',
  #   '1' => 'Ministerios',
  #   '12' => 'Agricultura,caza,silvicultura y pesca',
  #   '7' => 'Comercio,restaurantes y hoteles',
  #   '13' => 'Construcción',
  #   '15' => 'Electricidad,luz y agua',
  #   '9' => 'Establec.,financi.,seguros,bienes inmuebles',
  #   '16' => 'Explotación de minas y canteras',
  #   '10' => 'Industrias manufactureras',
  #   '8' => 'Servicios comunales,sociales y personales',
  #   '14' => 'Servicio Doméstico',
  #   '11' => 'Transporte,almacenamientos y  comunicac.'
  # }
  #
  # AREAS = {
  #   '1' => 'Salud',
  #   '2' => 'Educación',
  #   '3' => 'Fuerza armada',
  #   '4' => 'Seguridad',
  #   '5' => 'Económico',
  #   '6' => 'Agricultura',
  #   '7' => 'Medio ambiente',
  #   '8' => 'Turismo',
  #   '9' => 'Obra pública',
  #   '10' => 'Financiera',
  #   '11' => 'Transporte',
  #   '12' => 'Recreación',
  #   '13' => 'Desarrollo territorial',
  #   '14' => 'Otras'
  # }
  #
  # MINISTRIES = {
  #   '1' => 'Ministerio de agricultura y ganadería',
  #   '2' => 'Ministerio de economía',
  #   '3' => 'Ministerio de educación',
  #   '4' => 'Ministerio de gobernación y desarrollo territorial',
  #   '5' => 'Ministerio de hacienda',
  #   '6' => 'Ministerio de justicia y seguridad pública',
  #   '7' => 'Ministerio de la defensa nacional',
  #   '8' => 'Ministerio de medio ambiente y recursos naturales',
  #   '9' => 'Ministerio de obras públicas',
  #   '10' => 'Ministerio de relaciones exteriores',
  #   '11' => 'Ministerio de salud',
  #   '12' => 'Ministerio de trabajo y previsión social',
  #   '13' => 'Ministerio de turismo',
  #   '14' => 'Presidencia',
  #   '15' => 'Instituciones cerradas',
  #   '16' => 'No depende de ministerios'
  # }

  BUDGETS = {
    1 => 'Gobierno Central',
    2 => 'Gobiernos Locales',
    3 => 'Financieras',
    4 => 'Otros'
  }

  STATES = {
    1 => 'Alcaldías',
    2 => 'Ministerio Público',
    3 => 'Órgano Ejecutivo',
    4 => 'Órgano Judicial',
    5 => 'Órgano Legislativo',
    6 => 'Segundo grado',
    7 => 'Otros'
  }

  AREAS = {
    1 => 'Administración de Justicia',
    2 => 'Agricultura',
    3 => 'Cultura, turismo y deportes',
    4 => 'Defensa de Derechos Ciudadanos',
    5 => 'Economía e inversión',
    6 => 'Educación, ciencia y tecnología',
    7 => 'Empresas públicas financiera',
    8 => 'Empresas públicas no financieras',
    9 => 'Gobernación y Desarrollo Territorial',
    10 => 'Gobiernos Municipales',
    11 => 'Legislativo-normativo',
    12 => 'Medio Ambiente y Vulnerabilidad',
    13 => 'Obras Públicas, Transporte, Vivienda y Desarrollo Territorial',
    14 => 'Órganos de control y supervisión',
    15 => 'Otros',
    16 => 'Persecución del delito',
    17 => 'Protección y Seguridad Social',
    18 => 'Salud',
    19 => 'Seguridad pública'
  }

  TIMES = {
    '1' => 'Promedio anual',
    '2' => 'Anual',
    # '3' => 'Promedio mensual',
    '4' => 'Mensual'
  }

  GROUP_BY = {
    '0' => 'Sector',
    '1' => 'Rama de actividad económica',
    '2' => 'Según ley de presupuesto',
    '3' => 'Por Órganos de Estado',
    '4' => 'Por Áreas de gestión'
  }

  GROUP_BY_FIELD = {
    1 => 'ciiu_code',
    2 => 'class_a',
    3 => 'class_b',
    4 => 'class_c',
  }

  def readonly?
    true
  end

  def self.refresh
    ActiveRecord::Base.connection.execute('REFRESH MATERIALIZED VIEW emp_month_matview')
  end
end
