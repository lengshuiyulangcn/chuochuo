class AddLastTranslatedAtToPassage < ActiveRecord::Migration
  def change
	  add_column :passages, :last_translated_at, :datetime, :default=>Time.now
  end
end
