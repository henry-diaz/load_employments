class CreateCiiuCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :ciiu_categories do |t|
      t.string :code, limit: 1
      t.string :name
    end
  end
end
