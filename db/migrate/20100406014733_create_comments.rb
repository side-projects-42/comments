class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :name
      t.string :author_url
      t.string :email
      t.string :ip
      t.string :agent
      t.string :referrer
      t.string :body
      t.string :page_url
      t.boolean :spam
      t.integer :site_id

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
