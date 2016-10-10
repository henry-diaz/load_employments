require 'csv'
namespace :load do
  desc 'Carga de bienestar magisterial'
  task isbm: [:environment] do
    i = 0
    csv_path = "#{Rails.root.to_s}/db/bienestar.csv"
    employer = DimEmployer.where(nit: '01010101010101').first_or_create(name: 'Bienestar Magisterial', class_a: 1, class_b: 2, class_c: 3, sector: 1)
    CSV.foreach(csv_path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
      i = i + 1
      begin
        dim_time = DimTime.where(year: row[1], month: row[0]).first_or_create
        employment = FactEmployment.where(
          dim_time_id: dim_time.id,
          dim_employer_id: employer.id
        ).first_or_initialize
        employment.total = row[2]
        employment.amount = row[3].gsub(',', '.').to_f
        employment.up_amount = 0
        employment.down_amount = 0
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
    employer = DimEmployer.where(nit: '02020202020202').first_or_create(name: 'CEL', sector: 1, class_a: 2, class_b: 9, class_c: 9)
    CSV.foreach(csv_path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
      i = i + 1
      begin
        dim_time = DimTime.where(year: row[1], month: row[0]).first_or_create
        employment = FactEmployment.where(
          dim_time_id: dim_time.id,
          dim_employer_id: employer.id
        ).first_or_initialize
        employment.total = row[2].to_i - (row[4].present? ? row[4].to_i : 0)
        employment.amount = row[3].gsub(',', '').to_f - (row[5].present? ? row[5].gsub(',','').to_f : 0)
        employment.pensioned = row[4].to_i
        employment.up_amount = 0
        employment.down_amount = 0
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
    employer = DimEmployer.where(nit: '03030303030303').first_or_create(name: 'FAES', sector: 1, class_a: 1, class_b: 3, class_c: 7)
    CSV.foreach(csv_path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
      i = i + 1
      begin
        dim_time = DimTime.where(year: row[0], month: row[1]).first_or_create
        employment = FactEmployment.where(
          dim_time_id: dim_time.id,
          dim_employer_id: employer.id
        ).first_or_initialize
        employment.total = row[2].to_i - (row[4].present? ? row[4].to_i : 0)
        employment.amount = row[3].to_f - row[5].to_f
        employment.pensioned = row[4].to_i
        employment.up_amount = 0
        employment.down_amount = 0
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
    csv_path = "#{Rails.root.to_s}/db/clasificador_v2.csv"
    CSV.foreach(csv_path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
      begin
        nit = row[4].rjust(14, "0")
        employer = DimEmployer.where(nit: nit).first
        if employer

          open("#{Rails.root.to_s}/log/process.log", 'a') do |f|
            f.puts ""
            f.puts ""
            f.puts "#{nit}. #{row[3]}"
            f.puts "#{employer.nit}. #{employer.name}"
          end

          employer.class_a = row[0]
          employer.class_b = row[1]
          employer.class_c = row[2]
          employer.sector = 1
          employer.save
        end
      rescue
        puts "Error en la carga"
      end
    end
  end

  desc 'Corregir clasificaciones'
  task fix_classifications: [:environment] do
    DimEmployer.where(nit: '06142211071037').first.update_attributes(sector: 1, class_a: 1, class_b: 2, class_c: 3)
    DimEmployer.where(nit: '06141712041115').first.update_attributes(sector: 1, class_a: 2, class_b: 1, class_c: 16)
    DimEmployer.where(nit: '01010101010101').first.update_attributes(sector: 1, class_a: 1, class_b: 3, class_c: 7)
    DimEmployer.where(nit: '02020202020202').first.update_attributes(sector: 1, class_a: 2, class_b: 9, class_c: 9)
    DimEmployer.where(nit: '03030303030303').first.update_attributes(sector: 1, class_a: 2, class_b: 3, class_c: 1)
  end

  desc 'Cargar clasificaciones para privados'
  task extra_classifications: [:environment] do
    require 'csv'
    csv_path = "#{Rails.root.to_s}/db/privados.csv"
    CSV.foreach(csv_path, headers: true, encoding:'utf-8') do |row|
      begin
        nit = row[0].rjust(14, "0")
        employer = DimEmployer.where(nit: nit, sector: 0).first
        if employer
          employer.class_a = EmpMonthMatview::INSTITUTIONS.invert[row[3]]
          employer.save
        else
          # LOG failed insert data
          open("#{Rails.root.to_s}/log/process.log", 'a') do |f|
            f.puts ""
            f.puts ""
            f.puts "#{row.inspect}"
          end
        end
      rescue Exception => e
        puts "Error en la búsqueda #{e}"
      end
    end
  end
end
