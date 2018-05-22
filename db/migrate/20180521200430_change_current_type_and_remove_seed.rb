class ChangeCurrentTypeAndRemoveSeed < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :current_comment_id, :integer
    remove_column :users, :seed
  end
end
