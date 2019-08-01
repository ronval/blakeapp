class CreateSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :subjects do |t|
      t.string :name
      t.integer :teacher_id
      t.string :school_year
      t.timestamps

    end
  end
end
