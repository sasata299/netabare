class CreateMovies < ActiveRecord::Migration
  def self.up
    create_table :movies do |t|
      t.column :name, :string, :null => false
      t.column :image, :string, :null => false
      t.column :yurl, :string
      t.column :ytype, :string
      t.column :deleted, :integer, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :movies
  end
end
