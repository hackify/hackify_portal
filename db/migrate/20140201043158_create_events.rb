class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :room_name
      t.text :body
      t.boolean :open
      t.datetime :start
      t.string :password

      t.timestamps
    end
  end
end
