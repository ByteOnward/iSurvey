module CommentsHelper
  
  def username(user)
    if(user.username)
      user.username
    else
      user.email.gsub(/@.+$/, '')
    end
  end
  
  
end
