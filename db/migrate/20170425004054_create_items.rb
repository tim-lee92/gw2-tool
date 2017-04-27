class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.integer :item_id
      t.string :name, :image
      t.integer :rarity, :min_level, :type_id, :sub_type_id
    end
  end
end
