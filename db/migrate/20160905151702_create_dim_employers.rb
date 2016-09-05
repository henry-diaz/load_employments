class CreateDimEmployers < ActiveRecord::Migration[5.0]
  def change
    create_table :dim_employers do |t|
      t.string :nit
      t.string :name
      t.timestamps
    end
  end
end
