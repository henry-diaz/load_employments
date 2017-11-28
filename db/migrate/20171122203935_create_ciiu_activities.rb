class CreateCiiuActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :ciiu_activities do |t|
      t.references :ciiu_group, index: true
      t.string :name
    end
  end
end
