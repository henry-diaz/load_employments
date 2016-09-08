class AddAuditFieldsToTmpEmploymentsTable < ActiveRecord::Migration[5.0]
  def change
    add_column :tmp_employments, :state, :string, default: 'new'
    add_column :tmp_employments, :comment, :text
    add_index :tmp_employments, :state
  end
end
