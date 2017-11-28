class AddClassFieldsToTmpEmploymentsTable < ActiveRecord::Migration[5.0]
  def change
    add_column :tmp_employments, :class_a, :integer, default: nil
    add_column :tmp_employments, :class_b, :integer, default: nil
    add_column :tmp_employments, :class_c, :integer, default: nil
  end
end
