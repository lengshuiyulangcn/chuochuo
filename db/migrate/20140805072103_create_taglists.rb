class CreateTaglists < ActiveRecord::Migration
  def change
    create_table :taglists do |t|
      t.integer :tag_id
      t.integer :passage_id

      t.timestamps
    end
  end
end
