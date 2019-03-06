class CreateNodes < ActiveRecord::Migration[5.2]
  def self.up
    create_table :nodes do |t|
      t.string :node_type
      t.string :name
      t.integer :parent_id, :null => true, :index => true
      t.integer :lft, :null => false, :index => true
      t.integer :rgt, :null => false, :index => true

      # optional fields
      t.integer :depth, :null => false, :default => 0
      t.integer :children_count, :null => false, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :nodes
  end
end
