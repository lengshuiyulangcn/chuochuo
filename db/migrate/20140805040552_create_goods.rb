class CreateGoods < ActiveRecord::Migration
  def change
    create_table :goods do |t|
      t.integer :user_id
      t.integer :translation_id

      t.timestamps
    end
  end
end
