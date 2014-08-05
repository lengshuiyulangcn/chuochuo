class AddGoodcountToTranslation < ActiveRecord::Migration
  def change
    add_column :translations, :good_count, :integer, :default=>0
  end
end
