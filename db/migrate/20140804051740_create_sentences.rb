class CreateSentences < ActiveRecord::Migration
  def change
    create_table :sentences do |t|
      t.integer :passage_id
      t.integer :sentence_no
      t.string :content

      t.timestamps
    end
  end
end
