class AddTimeLimitedFieldsToSurvey < ActiveRecord::Migration
  def change
    add_column :surveys, :duration, :integer, :default => 65535
    add_column :surveys, :lock, :boolean, :default => false
  end
end
