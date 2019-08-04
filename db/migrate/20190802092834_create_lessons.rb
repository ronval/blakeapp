class CreateLessons < ActiveRecord::Migration[5.2]
  def change
    create_table :lessons do |t|
      t.integer :subject_id
      t.string :name
      t.timestamps
    end 
  end
end
