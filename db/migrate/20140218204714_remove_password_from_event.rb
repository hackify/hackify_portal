class RemovePasswordFromEvent < ActiveRecord::Migration
  def self.up
    remove_column :events, :password    
  end

  def self.down
    add_column :events, :password, :string
  end
end