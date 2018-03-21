class AddClassDFieldToTmpEmploymentsTable < ActiveRecord::Migration[5.0]
  def change
    add_column :tmp_employments, :class_d, :integer, default: nil
  end
end
