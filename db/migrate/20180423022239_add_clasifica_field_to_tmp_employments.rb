class AddClasificaFieldToTmpEmployments < ActiveRecord::Migration[5.0]
  def change
    add_column :tmp_employments, :clasifica, :string, limit: 2
  end
end
