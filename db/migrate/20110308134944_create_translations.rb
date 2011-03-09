class CreateTranslations < ActiveRecord::Migration
  def self.up
    create_table :translations do |t|
      t.integer :source_tu_id
      t.integer :target_tu_id
      t.integer :source_id
      t.boolean :is_public
      t.timestamps
    end
  end

  def self.down
    drop_table :translations
  end
end
