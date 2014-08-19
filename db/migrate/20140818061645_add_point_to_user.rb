class AddPointToUser < ActiveRecord::Migration
  def change
    add_column :users, :point, :integer, :default=>100
  end
end
