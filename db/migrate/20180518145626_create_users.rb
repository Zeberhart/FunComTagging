class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.text :email
      t.string :password_digest
      t.integer :current_comment_id
      t.timestamps
    end
  end
end
