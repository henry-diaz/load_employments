class AddDeptoMunicFieldToTmpEmploymentsTable < ActiveRecord::Migration[5.0]
  def change
    add_column :tmp_employments, :deptoMunic, :string, default: '', limit: 4
  end
end
