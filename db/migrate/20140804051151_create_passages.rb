class CreatePassages < ActiveRecord::Migration
  def change
    create_table :passages do |t|
      t.string :content
      t.integer :user_id
      t.integer :viewed, :default=>0

      t.timestamps
    end
  end
end
