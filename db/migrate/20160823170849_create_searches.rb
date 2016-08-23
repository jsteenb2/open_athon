class CreateSearches < ActiveRecord::Migration[5.0]
  def change
    create_table :searches do |t|
      t.string :zipcode
      t.timestamps
    end
  end
end
