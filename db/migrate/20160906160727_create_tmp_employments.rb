class CreateTmpEmployments < ActiveRecord::Migration[5.0]
  def change
    create_table :tmp_employments do |t|
      t.integer :anyo
      t.integer :mes
      t.string :nit
      t.integer :altasTrabajadores, default: 0
      t.decimal :altasSalarios, precision: 12, scale: 2
      t.integer :bajasTrabajadores, default: 0
      t.decimal :bajasSalarios, precision: 12, scale: 2
      t.integer :pensionados, default: 0
      t.integer :totalTrabajadores, default: 0
      t.decimal :salarios, precision: 12, scale: 2
      t.string :nombre
      t.timestamps
    end
  end
end
