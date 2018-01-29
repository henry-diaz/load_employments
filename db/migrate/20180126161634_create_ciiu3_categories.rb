class CreateCiiu3Categories < ActiveRecord::Migration[5.0]
  def change
    create_table :ciiu3_categories do |t|
      t.string :code, limit: 1
      t.string :name
    end
  end
end
