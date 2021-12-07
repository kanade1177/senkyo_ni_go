class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.integer :user_id
      t.string :category, null: false
      t.text :body
      t.string :title

      t.timestamps
    end
  end
end
