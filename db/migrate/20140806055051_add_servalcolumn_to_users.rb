class AddServalcolumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :icon, :string
    add_column :users, :bio, :string
    add_column :users, :qq, :string
  end
end
