class CreateFactDigestics < ActiveRecord::Migration[5.0]
  def change
    create_table :fact_digestics do |t|
      t.integer :year
      t.integer :occupied, defaul: 0
      t.integer :unoccupied, defaul: 0
      t.integer :inactive, defaul: 0
      t.integer :pea, defaul: 0
      t.integer :pet, defaul: 0
      t.timestamps
    end
  end
end
