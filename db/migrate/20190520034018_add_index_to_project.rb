class AddIndexToProject < ActiveRecord::Migration[5.2]
  def change
    add_index :projects, [:name, :slug], :unique => true
  end
end
