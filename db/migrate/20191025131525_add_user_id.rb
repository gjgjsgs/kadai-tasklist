class AddUserId < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :user, :references
  end
end
