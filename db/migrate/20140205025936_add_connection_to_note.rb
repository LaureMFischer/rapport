class AddConnectionToNote < ActiveRecord::Migration
  def change
    add_column :notes, :connection_id, :integer
    add_index :notes, :connection_id
  end
end
