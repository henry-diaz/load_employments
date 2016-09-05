class CreateDimTimes < ActiveRecord::Migration[5.0]
  def change
    create_table :dim_times do |t|
      t.integer :period
      t.integer :year
      t.integer :month
      t.string :month_str
      t.timestamps
    end
  end
end
