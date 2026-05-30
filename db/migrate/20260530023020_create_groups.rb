class CreateGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.text :introduction
      t.string :image_id
      t.string :owner_id

      t.timestamps
    end
  end
end
