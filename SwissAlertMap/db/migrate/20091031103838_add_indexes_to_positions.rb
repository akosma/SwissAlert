class AddIndexesToPositions < ActiveRecord::Migration
  def self.up
    add_index :positions, :code
    add_index :positions, :created_at
  end

  def self.down
    remove_index :positions, :created_at
    remove_index :positions, :code
    mint
  end
end
