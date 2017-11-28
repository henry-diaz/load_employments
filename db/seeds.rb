# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

=begin
require 'csv'
csv_path = "#{Rails.root.to_s}/db/tmp_employments.csv"
CSV.foreach(csv_path, headers: false) do |row|
  begin
    TmpEmployment.create(
      anyo: row[1],
      mes: row[2],
      nit: row[3],
      altasTrabajadores: row[4],
      altasSalarios: row[5],
      bajasTrabajadores: row[6],
      bajasSalarios: row[7],
      pensionados: row[8],
      totalTrabajadores: row[9],
      salarios: row[10],
      nombre: row[11]
    )
  rescue
    puts "Error en la carga"
  end
end
=end


# require 'csv'
# CSV.open("#{Rails.root.to_s}/db/employers_list.csv", "w") do |csv|
#   csv << ["NIT", "Nombre", "Sector", "Institución", "", "Área de gestión", "", "Ministerio", ""]
#   DimEmployer.order(sector: :desc, class_a: :asc, class_b: :asc, class_c: :asc).each do |e|
#     csv << [
#       e.nit,
#       e.name,
#       e.sector == 0 ? 'Privado' : 'Pública',
#       e.class_a.to_i > 0 ? "A#{e.class_a}" : '',
#       e.class_a.to_i > 0 ? EmpMonthMatview::INSTITUTIONS[e.class_a.to_s] : '',
#       e.class_b.to_i > 0 ? "B#{e.class_b}" : '',
#       e.class_b.to_i > 0 ? EmpMonthMatview::AREAS[e.class_b.to_s] : '',
#       e.class_c.to_i > 0 ? "C#{e.class_c}" : '',
#       e.class_c.to_i > 0 ? EmpMonthMatview::MINISTRIES[e.class_c.to_s] : ''
#     ]
#   end
# end

# require 'csv'
# csv_path = "#{Rails.root.to_s}/db/clasificador_patronos_completo.csv"
# # Todos por defecto son privados
# DimEmployer.update_all(sector: 0, class_a: 0, class_b: 0, class_c: 0)
# CSV.foreach(csv_path, headers: true) do |row|
#   begin
#     unless row[1].blank?
#       unless [1,8].include?(row[1].to_i)
#         # Es público, actualizamos esta clasificación en el patrono
#         e = DimEmployer.where(nit: row[0]).first
#         if e
#           e.update_column(:sector, 1)
#         else
#           puts "No se encontro el patrono con nit #{row[0]}"
#         end
#       end
#     end
#     #  unless [1,8].include?(row[1].to_i)
#     #    puts "#{row[1]} es en realidad #{[1,8].include?(row[1].to_i) ? 'privado' : 'público'}"
#     #  end
#   rescue
#     puts "Error en la carga"
#   end
# end
