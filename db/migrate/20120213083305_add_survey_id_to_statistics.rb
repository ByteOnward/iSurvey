class AddSurveyIdToStatistics < ActiveRecord::Migration
  def change
    add_column :statistics, :survey_id, :integer

  end
end
