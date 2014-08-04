class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.integer :user_id
      t.integer :sentence_id
      t.string :content

      t.timestamps
    end
  end
end
