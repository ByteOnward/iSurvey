module SurveysHelper
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end
  
  def link_to_template(f, object, association)
    fields = f.fields_for(association, object, :child_index => "new_placeholder") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    content_for((association.to_s.singularize + "_template").to_sym) do
      raw "<div id=\"#{association.to_s.singularize}_template\">#{fields}</div>"
    end
  end
    
  def new_question
    Question.new.tap{|q| 3.times{q.choices.build}}    
  end
  
  def new_choice
    Choice.new
  end
  
  def leading_choice(question)
    if(question.question_type == 1)
      raw check_box_tag("q[#{question.id}]", false) 
    else
      raw radio_button_tag("q[#{question.id}]", false) 
    end
  end
  
  def survey(stats)
    Survey.find(stats.survey_id)   
  end
  
  def stats_by_questions(stats)
    stats.records.reduce(Hash.new(0)){|m, r| m.tap{|ht| ht[r.question_id] += 1}}
  end
  
  def stats_by_choices(stats)
    stats.records.reduce(Hash.new(0)){|m, r| m.tap{|ht| ht[r.choice_id] += 1}}
  end


  def stats_of_percentage(stats, survey)
    questions = stats_by_questions(stats)
    choices = stats_by_choices(stats)
    result = {}
    survey.questions.each do |q|
      q.choices.each do |c|
        result[c.id] = choices[c.id] * 1.0 / questions[q.id]
      end
    end
    return result  
  end
  
end
