module ApplicationHelper
  
  def will_paginate_ajax(paginator, options={})  
    str = will_paginate(paginator, options)  
    if str != nil
      if options[:base_url] 
        str.gsub!(/(?<=href=")([^?]*)/) do |url|
          options[:base_url]
        end  
      end
      if options[:remote]
        str.gsub!(/(?<=href=")[^"]+"([^>]*)(?=>)/) do |attrs|
          attrs + ' data-remote="true"'
        end
      end
      str.html_safe 
    end       
  end
  
  
  def username(user)
    if(user.username)
      user.username
    else
      user.email.gsub(/@.+$/, '')
    end
  end
  
end
