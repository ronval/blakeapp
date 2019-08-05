class AddColumnAccessibleToAssignments < ActiveRecord::Migration[5.2]
  def change
    add_column :assignments, :accessible, :boolean, :default => false
    add_column :assignments, :subject_id, :integer
  end
end
