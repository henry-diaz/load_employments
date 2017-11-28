class UpdateFieldsInTmpEmploymentsTable < ActiveRecord::Migration[5.0]
  def change
    add_column :tmp_employments, :idPlanilla, :string
    add_column :tmp_employments, :periodo, :integer
    add_column :tmp_employments, :noPatronal, :string, limit: 9
    add_column :tmp_employments, :correlativoCT, :integer
    add_column :tmp_employments, :ciiu4, :integer
    add_column :tmp_employments, :ciiu3, :integer
    add_column :tmp_employments, :sector, :integer
    add_column :tmp_employments, :tipoSociedad, :integer
    add_column :tmp_employments, :estadoPlanilla, :integer
    add_column :tmp_employments, :conceptoEstadoPlanilla, :string, limit: 9
    add_index  :tmp_employments, :noPatronal
    add_index  :tmp_employments, :sector
    add_index  :tmp_employments, :ciiu4
    add_index  :tmp_employments, :ciiu3
  end
end
