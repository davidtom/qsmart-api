class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :phone_number
      t.string :profile_image_url, default: "http://thecampanile.org/wp-content/uploads/2016/10/blank-profile.jpg"

      t.timestamps
    end
  end
end
