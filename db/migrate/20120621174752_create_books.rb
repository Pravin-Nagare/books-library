class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.string :isbn
      t.timestamps
    end
    file=File.open("")
   end
  def self.down
  	drop_table :books
  end 
end
