class CreateLinesUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :lines_users do |t|
      t.integer :line_id
      t.integer :user_id
      t.boolean :waiting, default: true

      t.timestamps
    end
  end
end
