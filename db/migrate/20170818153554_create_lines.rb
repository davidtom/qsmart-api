class CreateLines < ActiveRecord::Migration[5.1]
  def change
    create_table :lines do |t|
      t.string :name
      t.integer :owner_id
      t.string :image_url
      t.string :type
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
