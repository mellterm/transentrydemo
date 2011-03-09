class CreateSourceTus < ActiveRecord::Migration
  def self.up
    create_table :source_tus do |t|
      t.string :content
      t.integer :language_id
      t.timestamps
    end
  end

  def self.down
    drop_table :source_tus
  end
end
