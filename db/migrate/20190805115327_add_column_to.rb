class AddColumnTo < ActiveRecord::Migration[5.2]
  def change
    add_column :assignment_chapters, :accessible, :boolean, :default => false
  end
end
