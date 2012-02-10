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
  
  
end
