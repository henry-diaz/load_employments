class AddSourceFieldToTmpEmploymentsTable < ActiveRecord::Migration[5.0]
  def change
    add_column :tmp_employments, :source, :integer, default: 0
    add_index :tmp_employments, :source
  end
end
