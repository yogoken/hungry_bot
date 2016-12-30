class CreateEngineers < ActiveRecord::Migration
  def change
    create_table :engineers do |t|
      t.string :last_name, null: false
      t.string :nickname, null: false
      t.text :image
      t.timestamps null: false
    end
  end
end
