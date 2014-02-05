class RemoveNoteFromConnections < ActiveRecord::Migration
  def change
    remove_column :connections, :note, :text
  end
end
