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
  
  def survey_groups
    roles = []
    if current_user.role?(:admin)
      roles = Role.all - Role.where(:name => 'Admin') - Role.where(:name => 'Owner')
    else
      roles = current_user.roles - Role.where(:name => 'Admin') - Role.where(:name => 'Owner')
    end
    roles.reduce({Public: 'Public'}){|m, role| m.tap{|ht|ht[role.name] = role.name}}
  end
  
  def time_left(survey)   
    left_days = survey.duration - seconds_to_day(Time.now - survey.created_at)
    if survey.duration < 10000 && left_days > 0      
      if block_given?              
        duration = "#{left_days} day"
        duration += "s" if left_days > 1
        yield duration
      else        
        "[#{survey.duration} days left]"
      end
    end
  end
  
  def seconds_to_day seconds
    (seconds / (60 * 60 * 24)).floor
  end
  
  def durations
    {
      "Unlimited" => 65535, 
      "1 day" => 1,
      "3 days" => 3, 
      "5 days" => 5, 
      "7 days" => 7, 
      "10 days" => 10, 
      "15 days" => 15, 
      "1 month" => 30,
      "2 months" => 60,
      "3 months" => 90,
      "6 months" => 180,
      "1 year" => 365,
      "3 year" => 365 * 3
    } 
  end
  
end
