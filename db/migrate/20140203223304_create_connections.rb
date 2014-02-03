class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.string :first_name
      t.string :last_name
      t.text :headline
      t.text :note
      t.references :user, index: true

      t.timestamps
    end
  end
end
