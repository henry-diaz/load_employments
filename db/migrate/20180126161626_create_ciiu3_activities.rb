class CreateCiiu3Activities < ActiveRecord::Migration[5.0]
  def change
    create_table :ciiu3_activities do |t|
      t.references :ciiu3_group, index: true
      t.string :name
    end
  end
end
