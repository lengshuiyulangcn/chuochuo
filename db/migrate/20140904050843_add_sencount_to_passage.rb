class AddSencountToPassage < ActiveRecord::Migration
  def change
    add_column :passages, :sencount, :integer
  end
end
