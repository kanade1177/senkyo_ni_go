class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :introduction, default: "", null: false
      t.text :image_id

      t.timestamps
      t.index :email, unique: true
    end
  end
end
