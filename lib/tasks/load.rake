require 'csv'
namespace :load do
  
  desc 'Carga de bienestar magisterial'
  task isbm: [:environment] do
    i = 0
    csv_path = "#{Rails.root.to_s}/db/bienestar.csv"
    name = 'Bienestar Magisterial (Institucional)'
    nit = '01010101010101'
    patronal = '010101010'
    employer = DimEmployer.where(nit: nit).first_or_create(name: name)
    CSV.foreach(csv_path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
      i = i + 1
      begin
        dim_time = DimTime.where(year: row[1], month: row[0]).first_or_create
        employment = TmpEmployment.where(
          'noPatronal' => patronal,
          nit: nit,
          anyo: row[1],
          mes: row[0],
          periodo: "#{row[1]}#{row[0].to_s.rjust(2, '0')}",
          salarios: row[3].gsub(',', '.').to_f,
          nombre: name,
          'totalTrabajadores' => row[2],
          ciiu4: 8430,
          ciiu3: 7530,
          sector: 3,
          'estadoPlanilla' => 1,
        ).first_or_initialize

        unless employment.save
          puts "No se pudo guardar #{row[0]}-#{row[1]}. #{employment.errors.full_messages.join(", ")}"
        end
      rescue
        puts "Error en la línea #{i}"
      end
    end
  end

  desc 'Carga CEL'
  task cel: [:environment] do
    i = 0
    csv_path = "#{Rails.root.to_s}/db/cel.csv"
    name = 'COMISION EJECUTIVA DEL RIO LEMPA CEL'
    nit = '02020202020202'
    patronal = '020202020'
    employer = DimEmployer.where(nit: nit).first_or_create(name: name)
    CSV.foreach(csv_path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
      i = i + 1
      begin
        dim_time = DimTime.where(year: row[1], month: row[0]).first_or_create
        employment = TmpEmployment.where(
          'noPatronal' => patronal,
          nit: nit,
          anyo: row[1],
          mes: row[0],
          periodo: "#{row[1]}#{row[0].to_s.rjust(2, '0')}",
          salarios: row[3].gsub(',', '').to_f - (row[5].present? ? row[5].gsub(',','').to_f : 0),
          nombre: name,
          'totalTrabajadores' => row[2].to_i - (row[4].present? ? row[4].to_i : 0),
          ciiu4: 3510,
          sector: 1,
          'estadoPlanilla' => 1,
          pensionados: row[4].to_i
        ).first_or_initialize
        unless employment.save
          puts "No se pudo guardar #{row[0]}-#{row[1]}. #{employment.errors.full_messages.join(", ")}"
        end
      rescue Exception => e
        puts "Error en la línea #{i}. #{e}"
      end
    end
  end

  desc 'Carga FAES'
  task faes: [:environment] do
    i = 0
    csv_path = "#{Rails.root.to_s}/db/faes.csv"
    name = 'FUERZA ARMADA'
    nit = '03030303030303'
    patronal = '030303030'
    employer = DimEmployer.where(nit: nit).first_or_create(name: name)
    CSV.foreach(csv_path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
      i = i + 1
      begin
        dim_time = DimTime.where(year: row[0], month: row[1]).first_or_create

        employment = TmpEmployment.where(
          'noPatronal' => patronal,
          nit: nit,
          anyo: row[0],
          mes: row[1],
          periodo: "#{row[0]}#{row[1].to_s.rjust(2, '0')}",
          salarios: row[3].to_f - row[5].to_f,
          nombre: name,
          'totalTrabajadores' => row[2].to_i - (row[4].present? ? row[4].to_i : 0),
          ciiu4: 8411,
          sector: 4,
          'estadoPlanilla' => 1,
          pensionados: row[4].to_i
        ).first_or_initialize
        unless employment.save
          puts "No se pudo guardar #{row[0]}-#{row[1]}. #{employment.errors.full_messages.join(", ")}"
        end
      rescue Exception => e
        puts "Error en la línea #{i}. #{e}"
      end
    end
  end

  desc 'Carga GEO'
  task geo: [:environment] do
    i = 0
    csv_path = "#{Rails.root.to_s}/db/geo.csv"
    name = 'LA GEO'
    nit = '04040404040404'
    patronal = '040404040'
    employer = DimEmployer.where(nit: nit).first_or_create(name: name)
    CSV.foreach(csv_path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
      i = i + 1
      begin
        dim_time = DimTime.where(year: row[0], month: row[1]).first_or_create

        employment = TmpEmployment.where(
          'noPatronal' => patronal,
          nit: nit,
          anyo: row[0],
          mes: row[1],
          periodo: "#{row[0]}#{row[1].to_s.rjust(2, '0')}",
          salarios: row[3].gsub(',', '.').to_f,
          nombre: name,
          'totalTrabajadores' => row[2].to_i,
          ciiu4: 3510,
          sector: 5,
          'estadoPlanilla' => 1,
          class_a: 1,
          class_b: 2,
          class_c: 8
        ).first_or_initialize
        unless employment.save
          puts "No se pudo guardar #{row[0]}-#{row[1]}. #{employment.errors.full_messages.join(", ")}"
        end
      rescue Exception => e
        puts "Error en la línea #{i}. #{e}"
      end
    end
  end

  desc 'Carga digestic'
  task digestic: [:environment] do
    require 'csv'
    csv_path = "#{Rails.root.to_s}/db/indicators.csv"
    CSV.foreach(csv_path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
      begin
        i = FactDigestic.where(year: row[0].strip).first_or_create
        i[row[1].strip.to_sym] = row[2]
        i.save
      rescue
        puts "Error en la carga"
      end
    end
  end

  desc 'Actualización clasificadores'
  task classifications: [:environment] do
    require 'csv'
    csv_path = "#{Rails.root.to_s}/db/clasificacion-publica.csv"
    CSV.foreach(csv_path, headers: true, encoding:'utf-8') do |row|
      # begin
        patronal = row[0].rjust(9, "0")
        records  = TmpEmployment.where('noPatronal' => patronal)
        if records.any?
          records.update_all(
            class_a: row[2].present? ? EmpMonthMatview::BUDGETS.invert[row[2].strip] : nil,
            class_b: row[3].present? ? EmpMonthMatview::STATES.invert[row[3].strip] : nil,
            class_c: row[4].present? ? EmpMonthMatview::AREAS.invert[row[4].strip] : nil,
          )
        else
          open("#{Rails.root.to_s}/log/process.log", 'a') do |f|
            f.puts ""
            f.puts "No se encontro el patron #{patronal} con nombre #{row[1]}"
          end
        end
      # rescue
        # puts "Hubo un error cargando: #{row.inspect}."
      # end
    end
  end

  # desc 'Corregir clasificaciones'
  # task fix_classifications: [:environment] do
  #   DimEmployer.where(nit: '06142211071037').first.update_attributes(sector: 1, class_a: 1, class_b: 2, class_c: 3)
  #   DimEmployer.where(nit: '06141712041115').first.update_attributes(sector: 1, class_a: 2, class_b: 1, class_c: 16)
  #   DimEmployer.where(nit: '01010101010101').first.update_attributes(sector: 1, class_a: 1, class_b: 3, class_c: 7)
  #   DimEmployer.where(nit: '02020202020202').first.update_attributes(sector: 1, class_a: 2, class_b: 9, class_c: 9)
  #   DimEmployer.where(nit: '03030303030303').first.update_attributes(sector: 1, class_a: 2, class_b: 3, class_c: 1)
  # end

  # desc 'Cargar clasificaciones para privados'
  # task extra_classifications: [:environment] do
  #   require 'csv'
  #   csv_path = "#{Rails.root.to_s}/db/listado_privados_1.csv"
  #   CSV.foreach(csv_path, headers: true, encoding:'utf-8') do |row|
  #     begin
  #       nit = row[0].rjust(14, "0") rescue nil
  #       employer = DimEmployer.where(nit: nit, sector: 0).first
  #       if employer
  #         employer.class_a = EmpMonthMatview::INSTITUTIONS.invert[row[3]]
  #         employer.save
  #       else
  #         # LOG failed insert data
  #         open("#{Rails.root.to_s}/log/process.log", 'a') do |f|
  #           f.puts ""
  #           f.puts ""
  #           f.puts "#{row.inspect}"
  #         end
  #       end
  #     rescue Exception => e
  #       puts "Error en la búsqueda #{e}"
  #     end
  #   end
  #   csv_path = "#{Rails.root.to_s}/db/listado_privados_2.csv"
  #   CSV.foreach(csv_path, headers: true, encoding:'utf-8') do |row|
  #     begin
  #       nit = row[0].rjust(14, "0") rescue nil
  #       employer = DimEmployer.where(nit: nit, sector: 0).first
  #       if employer
  #         employer.class_a = EmpMonthMatview::INSTITUTIONS.invert[row[3]]
  #         employer.save
  #       else
  #         # LOG failed insert data
  #         open("#{Rails.root.to_s}/log/process.log", 'a') do |f|
  #           f.puts ""
  #           f.puts ""
  #           f.puts "#{row.inspect}"
  #         end
  #       end
  #     rescue Exception => e
  #       puts "Error en la búsqueda #{e}"
  #     end
  #   end
  # end
end
