class AddGroupToNote < ActiveRecord::Migration
  def change
    add_reference :notes, :group, index: true, foreign_key: true
  end
end
