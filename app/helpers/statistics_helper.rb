module StatisticsHelper
  
  def is_selected(selected_choices, choice_id)
     return selected_choices.include?(choice_id)
  end
end
