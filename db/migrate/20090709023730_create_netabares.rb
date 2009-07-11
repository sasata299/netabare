class CreateNetabares < ActiveRecord::Migration
  def self.up
    create_table :netabares do |t|
      t.column :name, :string, :null => false
      t.column :url, :string, :null => false
      t.column :body, :text
      t.column :movie_id, :integer, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :netabares
  end
end
