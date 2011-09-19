class CreateFeedings < ActiveRecord::Migration
  def self.up
    create_table :feedings do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :feedings
  end
end
