class CreateFactEmployments < ActiveRecord::Migration[5.0]
  def change
    create_table :fact_employments do |t|
      t.references :dim_employer, index: true
      t.references :dim_time, index: true
      t.integer :total, default: 0
      t.decimal :amount, precision: 12, scale: 2
      t.integer :up, default: 0
      t.decimal :up_amount, precision: 12, scale: 2
      t.integer :down, default: 0
      t.decimal :down_amount, precision: 12, scale: 2
      t.integer :pensioned, default: 0
      t.timestamps
    end
    add_foreign_key :fact_employments, :dim_employers
    add_foreign_key :fact_employments, :dim_times
  end
end
