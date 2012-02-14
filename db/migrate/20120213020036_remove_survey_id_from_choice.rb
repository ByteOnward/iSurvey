class RemoveSurveyIdFromChoice < ActiveRecord::Migration
  def up
    remove_column :choices, :survey_id
  end

  def down
    add_column :choices, :survey_id, :integer
  end
end
