class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :user_id
      t.integer :passage_id
      t.integer :flour_id

      t.timestamps
    end
  end
end
