class CreateFoods < ActiveRecord::Migration[6.1]
  def change
    create_table :foods do |t|
      t.string :name,null: false
      t.text :explanation,null: false
      t.integer :genre_id,null: false
      t.integer :price,null: false
      t.boolean :sale_status,null: false,default: false
      t.timestamps
    end
  end
end
