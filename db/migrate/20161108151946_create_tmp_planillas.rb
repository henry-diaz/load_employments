class CreateTmpPlanillas < ActiveRecord::Migration[5.0]
  def change
    create_table :tmp_planillas do |t|
      t.integer :idPlanilla, index: true
      t.string :noPatronal
      t.string :nombrePatrono
      t.string :nit
      t.integer :estado
      t.string :estadoProcesamiento
      t.text :comentarioProcesamiento
      t.timestamps
    end
  end
end
