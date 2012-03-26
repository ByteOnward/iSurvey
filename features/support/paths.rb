  def path_to(page_name)
    case page_name
    
    when /homepage/
      root_path
    when /signup page/
      new_user_registration_path
    when /signin page/
      new_user_session_path
    when /SurveyCreation page/
      surveys_path
    when /SurveyView page/
      surveys_path

    # Add more page name => path mappings here
    
    else
      raise "Can't find mapping from \"#{page_name}\" to a path."
    end
  end

