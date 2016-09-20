class AddClassificationFieldsToDimEmployersTable < ActiveRecord::Migration[5.0]
  def change
    add_column :dim_employers, :sector, :integer, default: 0
    add_column :dim_employers, :class_a, :integer, default: 0
    add_column :dim_employers, :class_b, :integer, default: 0
    add_column :dim_employers, :class_c, :integer, default: 0
    add_index :dim_employers, :sector
    add_index :dim_employers, :class_a
    add_index :dim_employers, :class_b
    add_index :dim_employers, :class_c
  end
end
