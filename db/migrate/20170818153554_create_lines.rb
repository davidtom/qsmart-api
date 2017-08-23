class CreateLines < ActiveRecord::Migration[5.1]
  def change
    create_table :lines do |t|
      t.string :code
      t.string :name
      t.integer :owner_id
      t.string :image_url, default: "http://imgur.com/n00Ed17.jpg"
      t.string :type
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
