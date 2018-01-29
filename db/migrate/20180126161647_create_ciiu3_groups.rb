class CreateCiiu3Groups < ActiveRecord::Migration[5.0]
  def change
    create_table :ciiu3_groups do |t|
      t.references :ciiu3_division, index: true
      t.string :name
    end
  end
end
