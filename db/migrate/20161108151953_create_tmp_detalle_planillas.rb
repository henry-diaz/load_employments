class CreateTmpDetallePlanillas < ActiveRecord::Migration[5.0]
  def change
    create_table :tmp_detalle_planillas do |t|
      t.integer :idPlanilla, index: true
      t.integer :anyo
      t.integer :mes
      t.string :nitPatrono
      t.string :noAfiliacionTrabajador
      t.decimal :montoSalario, precision: 12, scale: 2
      t.decimal :montoPagoAdicional, precision: 12, scale: 2
      t.decimal :montoVacacion, precision: 12, scale: 2
      t.decimal :montoPresentado, precision: 12, scale: 2
      t.string :codigoObservacion
      t.string :estadoProcesamiento
      t.text :comentarioProcesamiento
      t.timestamps
    end
  end
end
