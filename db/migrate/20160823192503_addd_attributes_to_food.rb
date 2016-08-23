class AdddAttributesToFood < ActiveRecord::Migration[5.0]
  def change
    add_column :foods, :business_id, :string
    add_column :foods, :business_name, :string
    add_column :foods, :risk_category, :string
    add_column :foods, :violations, :string
    add_column :foods, :avg_score, :string
    add_column :foods, :business_latitude, :string
    add_column :foods, :business_longitude, :string
  end
end
