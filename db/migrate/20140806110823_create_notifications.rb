class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.string :content
      t.boolean :read, :default=>false

      t.timestamps
    end
  end
end
