class CreateCiiuGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :ciiu_groups do |t|
      t.references :ciiu_division, index: true
      t.string :name
    end
  end
end
