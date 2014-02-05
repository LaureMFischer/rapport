class AddDateToConnections < ActiveRecord::Migration
  def change
    add_column :connections, :date, :date
  end
end
