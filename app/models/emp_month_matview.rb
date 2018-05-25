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

  MINISTRIES = {
    1 => 'ACADEMIA NACIONAL DE SEGURIDAD PUBLICA',
    2 => 'ADMON NAC DE ACUEDUCTOS Y ALCANTARILLADO',
    3 => 'ASAMBLEA LEGISLATIVA',
    4 => 'AUTORIDAD DE AVIACION CIVIL',
    5 => 'AUTORIDAD MARITIMA PORTUARIA',
    6 => 'BANCO CENTRAL DE RESERVA DE EL SALVADOR',
    7 => 'BANCO DE DESARROLLO DE EL SALVADOR (BANDESAL)',
    8 => 'BANCO DE FOMENTO AGROPECUARIO',
    9 => 'BANCO DE TIERRAS',
    10 => 'BANCO HIPOTECARIO DE EL SALVADOR',
    11 => 'BANCO NACIONAL DE FOMENTO INDUSTRIAL',
    12 => 'CAJA MUTUAL DE LOS EMPLEADO DEL MINIST EDUCACION',
    13 => 'CASA PRESIDENCIAL Y SECRETARIAS',
    14 => 'CENTRO INTERNACIONAL DE FERIAS Y CONVENCIONES',
    15 => 'CENTRO NACIONAL DE REGISTROS',
    16 => 'CENTRO NACIONAL DE TECNOLOGIA AGROPECUARIA (CENTA)',
    17 => 'COMISION DEL NUEVO MILENIO',
    18 => 'COMISION EJECUTIVA HIDROELECTRICA RIO LEMPA',
    19 => 'COMISION EJECUTIVA PORTUARIA AUTONOMA',
    20 => 'COMISION DE DERECHOS HUMANOS DE EL SALVADOR',
    21 => 'COMISION NACIONAL DE ASISTENCIA A LA POBLACION DESPLAZADA  (CONADES)',
    22 => 'COMISION NACIONAL DE LA MICRO Y PEQUENA EMPRESA (CONAMYPE)',
    23 => 'COMISION NACIONAL DE PROMOCION DE INVERSIONES',
    24 => 'COMISION REVISADORA DE LA LEGISLACION SALVADORENA (CORELESAL)',
    25 => 'CONSEJO CENTRAL DE ELECCIONES',
    26 => 'CONSEJO NACIONAL DE LA JUDICATURA',
    27 => 'CONSEJO DE VIGILANCIA CONTADURIA PUBLICA Y AUDITORIA',
    28 => 'CONSEJO NACIONAL DE ADMINISTRACION DE BIENES',
    29 => 'CONSEJO NACIONAL DE ATENCION INTEGRAL A LA PERSONA CON DISCAP',
    30 => 'CONSEJO NACIONAL DE CALIDAD  (CNC)',
    31 => 'CONSEJO NACIONAL DE CIENCIA Y TECNOLOGIA (CONACYT)',
    32 => 'CONSEJO NACIONAL DE ENERGIA  (CNE)',
    33 => 'CONSEJO NACIONAL DE LA NINEZ Y DE LA ADOLESCENCIA (CONNA)',
    34 => 'CONSEJO SALVADORENO DE LA AGROINDUSTRIA AZUCARERA (CONSA)',
    35 => 'CONSEJO SALVADORENO DE MENORES',
    36 => 'CONSEJO SALVADORENO DEL CAFE',
    37 => 'CONSEJO SUPERIOR DE SALUD PUBLICA',
    38 => 'CORTE DE CUENTAS DE LA REPUBLICA',
    39 => 'CORPORACION SALVADORENA DE INVERSIONES  (CORSAIN)',
    40 => 'CORPORACION SALVADORENA DE TURISMO',
    41 => 'CRUZ ROJA SALVADORENA',
    42 => 'DEFENSORIA DEL CONSUMIDOR',
    43 => 'DIRECCION NACIONAL DE MEDICAMENTOS',
    44 => 'DIRECCION GENERAL DE PROTECCION AL CONSUMIDOR',
    45 => 'ESCUELA NACIONAL DE AGRICULTURA ROBERTO QUINONEZ (ENA)',
    46 => 'FERROCARRILES NACIONALES DE EL SALVADOR',
    47 => 'FINANCIERA NACIONAL DE TIERRAS AGRICOLAS',
    48 => 'FISCALIA GENERAL DE LA REPUBLICA',
    49 => 'FONDO AMBIENTAL DE EL SALVADOR  (FONAES)',
    50 => 'FONDO DE ACTIVIDADES ESPECIALES  DE MEDIOS DE COMUNICACION Y',
    51 => 'FONDO DE CONSERVACION VIAL (FOVIAL)',
    52 => 'FONDO DE FINANCIAMIENTO GTIA PEQUENA EMPRESA',
    53 => 'FONDO DE GARANTIA PARA CREDITO EDUCATIVO',
    54 => 'FONDO DE INVERSION NACIONAL EN ELECTRICIDAD Y TELEFONIA (FINE)',
    55 => 'FONDO DE INVERSION SOCIAL PARA EL DESARROLLO LOCAL (FISDL)',
    56 => 'FONDO DE PROTECCION DE LISIADOS Y DISCAPACITADOS A CONSECUENC',
    57 => 'FONDO DE SANEAMIENTO Y FORTALECIMIENTO FINANCIERO',
    58 => 'FONDO DEL MILENIO',
    59 => 'FONDO NACIONAL DE VIVIENDA  POPULAR',
    60 => 'FONDO PARA LA ATENCION A LAS VICTIMAS DE ACCIDENTES DE TRANSI',
    61 => 'FONDO SALVADORENO PARA ESTUDIOS DE PREINVERSION  (FOSEP)',
    62 => 'FONDO SOCIAL PARA LA VIVIENDA',
    63 => 'FONDO SOLIDARIO PARA LA FAMILIA MICROEMP (FOSOFAMILIA)',
    64 => 'FONDO SOLIDARIO PARA LA SALUD (FOSALUD)',
    65 => 'GOBIERNOS LOCALES (ALCALDIAS)',
    66 => 'INSTITUTO DE ACCESO A LA INFORMACION PUBLICA',
    67 => 'INSTITUTO DE LEGALIZACION DE LA PROPIEDAD',
    68 => 'INSTITUTO DE PREVISION SOCIAL DE LA FUERZA ARMADA',
    69 => 'INSTITUTO NACIONAL DE LOS DEPORTES',
    70 => 'INSTITUTO NACIONAL DEL AZUCAR',
    71 => 'INSTITUTO NACIONAL PENSIONES EMPLEADOS PUBLICOS',
    72 => 'INSTITUTO REGULADOR DE ABASTECIMIENTOS',
    73 => 'INSTITUTO SALVADORENO DEL SEGURO SOCIAL',
    74 => 'INSTITUTO SALVADORENO DE BIENESTAR MAGISTERIAL',
    75 => 'INSTITUTO SALVADORENO DE FORMAC PROFESIONAL (INSAFORP)',
    76 => 'INSTITUTO SALVADORENO DE REHABILITACION INTEGRAL',
    77 => 'INSTITUTO SALVADORENO DE DESARROLLO MUNICIPAL  (ISDEM)',
    78 => 'INSTITUTO SALVADORENO DE FOMENTO COOPERATIVO  (INSAFOCOOP)',
    79 => 'INSTITUTO SALVADORENO DE FOMENTO INDUSTRIAL',
    80 => 'INSTITUTO SALVADORENO DE INVESTIGACION  DEL CAFE',
    81 => 'INSTITUTO SALVADORENO DE PROTECCION MENOR',
    82 => 'INSTITUTO SALVADORENO DE TRANSFORMACION AGRARIA (ISTA)',
    83 => 'INSTITUTO SALVADORENO DE TURISMO',
    84 => 'INSTITUTO SALVADORENO PARA EL DESARROLLO INTEGRAL DE LA NINEZ',
    85 => 'INSTITUTO SALVADORENO PARA EL DESARROLLO DE LA MUJER  (ISDEMU)',
    86 => 'LOTERIA NACIONAL DE BENEFICENCIA',
    87 => 'MINISTERIO DE AGRICULTURA Y GANADERIA',
    88 => 'MINISTERIO DE CULTURA Y COMUNICACIONES',
    89 => 'MINISTERIO DE ECONOMIA',
    90 => 'MINISTERIO DE EDUCACION',
    91 => 'MINISTERIO DE GOBERNACION',
    92 => 'MINISTERIO DE HACIENDA',
    93 => 'MINISTERIO DE JUSTICIA Y SEGURIDAD PUBLICA',
    94 => 'MINISTERIO DE LA DEFENSA NACIONAL',
    95 => 'MINISTERIO DE MEDIOAMBIENTE Y RECURSOS NATURALES',
    96 => 'MINISTERIO DE OBRAS PUBLICAS',
    97 => 'MINISTERIO DE PLANIFICACIÓN',
    98 => 'MINISTERIO DE RELACIONES EXTERIORES',
    99 => 'MINISTERIO DE SALUD',
    100 => 'MINISTERIO DE TRABAJO Y PREVISION SOCIAL',
    101 => 'MINISTERIO DE TURISMO',
    102 => 'OFICINA DE PLANIFICACION DEL AREA METROPOLITANA  (OPAMS)',
    103 => 'ORGANO JUDICIAL',
    104 => 'ORGANISMO PROMOTOR DE EXPORTACIONES E INVERSIONES (PROESA)',
    105 => 'PARLAMENTO CENTROAMERICANO SUBSEDE DE EL SALVADOR',
    106 => 'PROCURADURIA DEFENSA DERECHOS HUMANOS',
    107 => 'PROCURADURIA GENERAL DE LA REPUBLICA',
    108 => 'REGISTRO NACIONAL DE LAS PERSONAS NATURALES  (RNPN)',
    109 => 'SUPERINTENDENCIA DE COMPETENCIA',
    110 => 'SUPERINTENDENCIA DE PENSIONES',
    111 => 'SUPERINTENDENCIA DE VALORES',
    112 => 'SUPERINTENDENCIA DEL SISTEMA FINANCIERO',
    113 => 'SUPERINTENDENCIA GENERAL DE ELECTRICIDAD Y TELECOMUNICACIONES',
    114 => 'TRIBUNAL DE ETICA GUBERNAMENTAL',
    115 => 'TRIBUNAL DE SERVICIO CIVIL',
    116 => 'TRIBUNAL SUPREMO ELECTORAL',
    117 => 'UNIDAD TECNICA EJECUTIVA DEL SECTOR JUSTICIA "UTE"  (PROYECTO GOES/AID)',
    118 => 'UNIVERSIDAD DE EL SALVADOR',
    119 => 'FUERZA ARMADA',
    120 => 'LA GEO',
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
    '4' => 'Por Áreas de gestión',
    '5' => 'Por Ministerios e Instituciones',
  }

  GROUP_BY_STATISTICS = {
    '0' => 'Sector',
    '6' => 'Por clasificación en el anuario',
  }

  GROUP_BY_FIELD = {
    1 => 'ciiu_code',
    2 => 'class_a',
    3 => 'class_b',
    4 => 'class_c',
    5 => 'clasifica',
  }
  ANUARIES = {
    '01' => 'Agricultura, Caza, Silvicultura y Pesca',
    '02' => 'Explotación de Minas y Canteras',
    '03' => 'Industrias Manufactureras',
    '04' => 'Electricidad, Gas y Agua',
    '05' => 'Construcción',
    '06' => 'Comercio por mayor y menor, Restaurantes y Hoteles',
    '07' => 'Transporte, Almacenamiento y Comunicaciones',
    '08' => 'Establecimienos Financieros, Seguros, Bienes Inmuebles y Servicios Prestados a las Empresas',
    '09' => 'Servicios Comunales, Sociales y Personales',
    '10' => 'Sector Doméstico',
    '11' => 'Administracion Pública',
    '12' => 'Instituciones Descentralizadas',
    '13' => 'Instituciones de Seguridad Social',
    '14' => 'Empresas no Financieras',
    '15' => 'Salvadoreños en el Exterior',
    '16' => 'Empresas Financieras',
    '17' => 'Gobiernos Locales (Municipalidades)',
  }

  def readonly?
    true
  end

  def self.refresh
    ActiveRecord::Base.connection.execute('REFRESH MATERIALIZED VIEW emp_month_matview')
  end

  def self.grouped_name gvalue, gid, ciiu_categories
    value = case gid
      when 1
        ciiu_categories[gvalue.to_s]
      when 2
        BUDGETS[gvalue]
      when 3
        STATES[gvalue]
      when 4
        AREAS[gvalue]
      when 5
        MINISTRIES[gvalue]
      when 6
        ANUARIES[gvalue]
    end
    value || 'Sin clasificar'
  end

end
