class RenamePublicInTodos < ActiveRecord::Migration[5.2]
  def change
    rename_column :todos, :public, :is_public
  end
end
