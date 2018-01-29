require 'csv'
namespace :dae do

  desc 'Load DAE info'
  task load: [:environment] do



    ###
    # 2001
    ###
    csv_path = "#{Rails.root.to_s}/db/csv_estadisticas/cotizantes_2001.csv"
    CSV.foreach(csv_path, headers: true, encoding:'utf-8', col_sep: ';') do |row|
      begin

        TmpEmployment.where(noPatronal: row[0], sector: row[4], periodo: row[10]).first_or_create(
            nombre: row[1],
            ciiu3: row[11],
            deptoMunic: row[5],
            totalTrabajadores: row[6],
            salarios: row[7].gsub(',', '.'),
            source: 1 # DAE
          )

      rescue
        puts "Hubo un error cargando: #{row.inspect}."
      end
    end

    ###
    # 2002, 2003
    ###
    [
      "#{Rails.root.to_s}/db/csv_estadisticas/cotizantes_2002.csv",
      "#{Rails.root.to_s}/db/csv_estadisticas/cotizantes_2003.csv",
    ].each do |csv_path|
      CSV.foreach(csv_path, headers: true, encoding:'utf-8', col_sep: ';') do |row|
        begin
          TmpEmployment.where(noPatronal: row[0], sector: row[4], periodo: row[9]).first_or_create(
              nombre: row[1],
              ciiu3: row[11],
              deptoMunic: row[5],
              totalTrabajadores: row[6],
              salarios: row[7].gsub(',', '.'),
              source: 1 # DAE
            )
        rescue
          puts "Hubo un error cargando: #{row.inspect}."
        end
      end
    end

    ###
    # 2004
    ###
    csv_path = "#{Rails.root.to_s}/db/csv_estadisticas/cotizantes_2004.csv"
    CSV.foreach(csv_path, headers: true, encoding:'utf-8', col_sep: ';') do |row|
      begin
        TmpEmployment.where(noPatronal: row[0], sector: row[4], periodo: row[8]).first_or_create(
            nombre: row[1],
            ciiu3: row[13],
            deptoMunic: row[5],
            totalTrabajadores: row[6],
            salarios: row[7].gsub(',', '.'),
            source: 1 # DAE
          )
      rescue
        puts "Hubo un error cargando: #{row.inspect}."
      end
    end

    ###
    # 2005, 2006, 2007
    ###
    [
      "#{Rails.root.to_s}/db/csv_estadisticas/cotizantes_2005.csv",
      "#{Rails.root.to_s}/db/csv_estadisticas/cotizantes_2006.csv",
      "#{Rails.root.to_s}/db/csv_estadisticas/cotizantes_2007.csv",
    ].each do |csv_path|
      CSV.foreach(csv_path, headers: true, encoding:'utf-8', col_sep: ';') do |row|
        begin
          TmpEmployment.where(noPatronal: row[0], sector: row[4], periodo: row[8]).first_or_create(
              nombre: row[1],
              ciiu3: row[14],
              deptoMunic: row[5],
              totalTrabajadores: row[6],
              salarios: row[7].gsub(',', '.'),
              source: 1 # DAE
            )
        rescue
          puts "Hubo un error cargando: #{row.inspect}."
        end
      end
    end

    ###
    # 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016
    ###
    [
      "#{Rails.root.to_s}/db/csv_estadisticas/cotizantes_2008.csv",
      "#{Rails.root.to_s}/db/csv_estadisticas/cotizantes_2009.csv",
      "#{Rails.root.to_s}/db/csv_estadisticas/cotizantes_2010.csv",
      "#{Rails.root.to_s}/db/csv_estadisticas/cotizantes_2011.csv",
      "#{Rails.root.to_s}/db/csv_estadisticas/cotizantes_2012.csv",
      "#{Rails.root.to_s}/db/csv_estadisticas/cotizantes_2013.csv",
      "#{Rails.root.to_s}/db/csv_estadisticas/cotizantes_2014.csv",
      "#{Rails.root.to_s}/db/csv_estadisticas/cotizantes_2015.csv",
      "#{Rails.root.to_s}/db/csv_estadisticas/cotizantes_2016.csv",
    ].each do |csv_path|
      CSV.foreach(csv_path, headers: true, encoding:'utf-8', col_sep: ';') do |row|
        begin
          TmpEmployment.where(noPatronal: row[0], sector: row[6], periodo: row[10]).first_or_create(
              nombre: row[1],
              ciiu3: row[4],
              deptoMunic: row[7],
              totalTrabajadores: row[8],
              salarios: row[9].gsub(',', '.'),
              nit: row[15],
              source: 1 # DAE
            )
        rescue
          puts "Hubo un error cargando: #{row.inspect}."
        end
      end
    end




  end

end
