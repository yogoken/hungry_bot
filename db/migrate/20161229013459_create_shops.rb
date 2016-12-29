class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :name, null: false
      t.text :url
      t.timestamps null: false
    end
  end
end
