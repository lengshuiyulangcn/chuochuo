class AddPassageIdToTranslations < ActiveRecord::Migration
  def change
    add_column :translations, :passage_id, :integer
  end
end
