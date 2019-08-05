class CreateEnrollments < ActiveRecord::Migration[5.2]
  def change
    create_table :enrollments do |t|
      t.integer :student_id
      t.integer :subject_id
      t.timestamps
    end

    remove_column :students, :subject_id
  end
end
