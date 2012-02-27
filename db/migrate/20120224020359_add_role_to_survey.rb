class AddRoleToSurvey < ActiveRecord::Migration
  def change
    add_column :surveys, :role, :string
  end
end
