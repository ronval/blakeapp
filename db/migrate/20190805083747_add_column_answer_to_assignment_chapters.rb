class AddColumnAnswerToAssignmentChapters < ActiveRecord::Migration[5.2]
  def change
    add_column :assignment_chapters, :answer ,:text
  end
end
