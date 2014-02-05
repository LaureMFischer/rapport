class AddLinkedinidToConnections < ActiveRecord::Migration
  def change
    add_column :connections, :linkedin_id, :string
  end
end
