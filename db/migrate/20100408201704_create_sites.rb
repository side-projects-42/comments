class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.string :name
      t.string :url
      t.string :token
      t.string :akismet_key

      t.timestamps
    end
  end

  def self.down
    drop_table :sites
  end
end
