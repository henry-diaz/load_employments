class CreateCiiuDivisions < ActiveRecord::Migration[5.0]
  def change
    create_table :ciiu_divisions do |t|
      t.string :category_code, index: true, limit: 1
      t.string :name
    end
  end
end
