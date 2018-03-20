class AddDeptoAndMunicFieldsToTmpEmploymentsTable < ActiveRecord::Migration[5.0]
  def change
    add_column :tmp_employments, :depto, :integer, default: nil
    add_column :tmp_employments, :munic, :integer, default: nil
  end
end
