class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.text :body
      t.boolean :split, :default => false
      t.integer :comment_id
      t.integer :user_id
      t.timestamps
    end
  end
end
