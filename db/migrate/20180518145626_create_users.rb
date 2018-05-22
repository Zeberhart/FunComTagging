class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.text :email
      t.string :password_digest
      t.text :current_comment_id
      t.integer :seed
      t.timestamps
    end
  end
end
