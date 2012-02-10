rails generate devise:install

rails generate devise User

before_filter :authenticate_user!

To verify if a user is signed in, use the following helper:
user_signed_in?


For the current signed-in user, this helper is available:
current_user


You can access the session for this scope:
user_session

You can also overwrite +after_sign_in_path_for+ and +after_sign_out_path_for+ to customize your redirect hooks.

Finally, you need to set up default url options for the mailer in each environment. Here is the configuration for "config/environments/development.rb":

config.action_mailer.default_url_options = { :host => 'localhost:3000' }


Configuring views

We built Devise to help you quickly develop an application that uses authentication. However, we don't want to be in your way when you need to customize it.

Since Devise is an engine, all its views are packaged inside the gem. These views will help you get started, but after some time you may want to change them. If this is the case, you just need to invoke the following generator, and it will copy all views to your application:

rails generate devise:views
If you have more than one role in your application (such as "User" and "Admin"), you will notice that Devise uses the same views for all roles. Fortunately, Devise offers an easy way to customize views. All you need to do is set "config.scoped_views = true" inside "config/initializers/devise.rb".

After doing so, you will be able to have views based on the role like "users/sessions/new" and "admins/sessions/new". If no view is found within the scope, Devise will use the default view at "devise/sessions/new". You can also use the generator to generate scoped views:

rails generate devise:views users


Configuring controllers

If the customization at the views level is not enough, you can customize each controller by following these steps:

1) Create your custom controller, for example a Admins::SessionsController:

class Admins::SessionsController < Devise::SessionsController
end
2) Tell the router to use this controller:

devise_for :admins, :controllers => { :sessions => "admins/sessions" }
3) And since we changed the controller, it won't use the "devise/sessions" views, so remember to copy "devise/sessions" to "admin/sessions".

Remember that Devise uses flash messages to let users know if sign in was successful or failed. Devise expects your application to call "flash[:notice]" and "flash[:alert]" as appropriate.

Configuring routes

Devise also ships with default routes. If you need to customize them, you should probably be able to do it through the devise_for method. It accepts several options like :class_name, :path_prefix and so on, including the possibility to change path names for I18n:

devise_for :users, :path => "usuarios", :path_names => { :sign_in => 'login', :sign_out => 'logout', :password => 'secret', :confirmation => 'verification', :unlock => 'unblock', :registration => 'register', :sign_up => 'cmon_let_me_in' }
Be sure to check +devise_for+ documentation for details.

If you have the need for more deep customization, for instance to also allow "/sign_in" besides "/users/sign_in", all you need to do is to create your routes normally and wrap them in a +devise_scope+ block in the router:

devise_scope :user do
  get "sign_in", :to => "devise/sessions#new"
end
This way you tell devise to use the scope :user when "/sign_in" is accessed. Notice +devise_scope+ is also aliased as +as+ and you can also give a block to +devise_for+, resulting in the same behavior:

devise_for :users do
  get "sign_in", :to => "devise/sessions#new"
end
Feel free to choose the one you prefer!








config/initializers/omniauth.rb:

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
end

match '/auth/:provider/callback', to: 'sessions#create'

rails g scaffold Authentication user_id:integer provider:string uid:string












 {"utf8"=>"✓", "authenticity_token"=>"O1pxJ/1XzX6iZCvsvhT8SoKCxTwSGOULRpfSsNcxLUE=", 
"questionaire"=>{
	"name"=>"aa", 
	"questions_attributes"=>{
		"0"=>{
			"_destroy"=>"false", 
			"content"=>"b", 
			"answers_attributes"=>{
				"0"=>{
					"content"=>"c", 
					"_destroy"=>"false"
				}, 
				"1"=>{
					"content"=>"de", 
					"_destroy"=>"false"
				}, 
				"2"=>{
					"content"=>"e", 
					"_destroy"=>"false"
				}, 
				"3"=>{
					"content"=>"f", 
					"_destroy"=>"false"
				}
			}
		}, 
		"1"=>{
			"_destroy"=>"false", 
			"content"=>"g", 
			"answers_attributes"=>{"0"=>{"content"=>"h", "_destroy"=>"false"}, "1"=>{"content"=>"i", "_destroy"=>"false"}, "2"=>{"content"=>"j", "_destroy"=>"false"}, "3"=>{"content"=>"k", "_destroy"=>"false"}}}, "2"=>{"_destroy"=>"false", "content"=>"l", "answers_attributes"=>{"0"=>{"content"=>"m", "_destroy"=>"false"}, "1"=>{"content"=>"n", "_destroy"=>"false"}, "2"=>{"content"=>"o", "_destroy"=>"false"}, "3"=>{"content"=>"p", "_destroy"=>"false"}}}}}, "commit"=>"Submit"}