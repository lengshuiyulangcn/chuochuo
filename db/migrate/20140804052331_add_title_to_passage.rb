class AddTitleToPassage < ActiveRecord::Migration
  def change
    add_column :passages, :title, :string
  end
end
