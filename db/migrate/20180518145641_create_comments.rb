class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :function_id
      t.string :function_body
      t.string :file_name
      t.timestamps
    end
  end
end
