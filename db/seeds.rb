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
