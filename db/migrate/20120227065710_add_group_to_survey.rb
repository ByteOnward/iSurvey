class AddGroupToSurvey < ActiveRecord::Migration
  def change
    add_column :surveys, :group, :string, :default => 'Public'
  end
end
