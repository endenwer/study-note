class AddAuthorAndLastEditorToNote < ActiveRecord::Migration
  def change
    add_column :notes, :author_id, :integer, index: true, foreign_key: true
    add_column :notes, :last_editor_id, :integer, index: true, foreign_key: true
  end
end
