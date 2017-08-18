class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.integer :phone_number
      t.string :profile_image_url

      t.timestamps
    end
  end
end
