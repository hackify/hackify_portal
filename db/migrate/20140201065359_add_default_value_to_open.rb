class AddDefaultValueToOpen < ActiveRecord::Migration
  def up
      change_column :events, :open, :boolean, :default => false
  end

  def down
      change_column :events, :open, :boolean, :default => nil
  end  
end
