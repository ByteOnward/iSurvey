class RemoveRoleFromSurvey < ActiveRecord::Migration
  def up
    remove_column :surveys, :role
  end

  def down
    add_column :surveys, :role, :string
  end
end
