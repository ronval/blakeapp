class CreateSections < ActiveRecord::Migration[5.2]
  def change
    create_table :sections do |t|
      t.integer :lesson_id
      t.text :content
      t.timestamps
    end
  end
end
