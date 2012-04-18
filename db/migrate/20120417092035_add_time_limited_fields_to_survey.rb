class AddTimeLimitedFieldsToSurvey < ActiveRecord::Migration
  def change
    add_column :surveys, :duration, :integer
    add_column :surveys, :lock, :boolean, :default => false
  end
end
