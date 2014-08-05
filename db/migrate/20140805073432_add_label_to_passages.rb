class AddLabelToPassages < ActiveRecord::Migration
  def change
    add_column :passages, :label, :string
  end
end
