class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :body
      t.date :date_of_interaction
      t.timestamps
    end
  end
end
