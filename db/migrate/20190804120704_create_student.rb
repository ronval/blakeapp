class CreateStudent < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :full_name
      t.integer :subject_id
      t.string :email
      t.timestamps
    end

    create_table :assignments do |t|
      t.integer :student_id
      t.integer :lesson_id
      t.boolean :completed, default: false
      t.timestamps
    end

    create_table :assignment_chapters do |t|
      t.boolean :correct
      t.boolean :completed, default: false
      t.text :content
      t.integer :assignment_id
      t.timestamps
    end 


  end
end
