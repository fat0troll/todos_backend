class AddPublicToTodos < ActiveRecord::Migration[5.2]
  def change
    add_column :todos, :public, :bool, :default => false
  end
end
