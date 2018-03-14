Authentication

1) Add has_secure_password() method to models/user.rb:

   class User < ActiveRecord::Base
    has_many :articles
    before_save { self.email = email.downcase }
    validates :username, presence:true, 
              uniqueness: { case_sensitive:false }, 
              length: { minimum: 3, maximum: 25 }

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, 
              length: { maximum: 105 },
              uniqueness: { case_sensitive: false },
              format: { with: VALID_EMAIL_REGEX }
    has_secure_password
  end

2) Go to Gemfile and type:

  gem 'bcrypt', '~> 3.1.7'

3) Install Gem, type: bundle install --without production

4) Generate migration file to add password to the "users" table in schema.rb

  Type: rails generate migration add_password_digest_to_users

5) Go to newly created migration file and add new column to users table.5

    Type:

    class AddPasswordDigestToUsers < ActiveRecord::Migration
      def change
        add_column :users, :password_digest, :string => adds new column to users table in schema.rb
      end
    end

6) Go rails console and create a new user:

   Type: user = User.new(username: "Steboogs", email: "steveng@gmail.com") => creates new user
   Type: user.password = "somepassword"
   Type: user.save => Displays password_digest with hashed password
   Type: user.authenticate("password") => Displays the user is correct password is passed
   Type: User.all => shows all users created in the database


Adding Users from the UI

1) Go to config/routes.rb and create route for sign up page
  
  Type:

  #"users" = controller, "new" = action defined in controller
  get 'signup', to: 'users#new'
  
  
2) Create a controller file, users.controller.rb. Create new action.
    
  class UsersController < ApplicationController
    def new
    
    end
  end

  
3) Create html template for new page. 
  
    -Create views/users folder. 
    -Create views/users/new.html.erb
  
4) Copy and paste articles/_form.html.erb file into users/new.html.erb like so:

   Notes: 

   1) change "obj: @article" to "obj: @user"
   2) Make the following changes to display username, email, and password
   3) Change button to say "Sign up"
    

    <h1 class="text-center"> Signup for Alpha Blog </h1>
           
    <%= render 'shared/errors', obj: @user %> => changes to "@user" because it will pass the users error messages here

    <div class="row">
      <div class='col-xs-12'>

            <%= form_for(@user, :html => {class: "form-horizontal", role: "form"}) do |f| %>
            <div class="form-group">
              <div class="control-label col-sm-2">
                  <!--Displays "Username" -->
                  <%= f.label :username %> 
              </div>
              <div class="col-sm-8">
                  <!--Displays input box, ":title" grabs from  -->
                  <%= f.text_field :username, class: "form-control", placeholder: "Enter Username", autofocus: true %>    
              </div>
           </div>

           <div class="form-group">
              <div class="control-label col-sm-2">
                  <!--Displays "Email" -->
                  <%= f.label :email %> 
             </div>
              <div class="col-sm-8">
                  <!--Displays input box -->
                  <%= f.email_field :email, class:"form-control", placeholder: "Enter your email" %> 
             </div>
          </div>


           <div class="form-group">
              <div class="control-label col-sm-2">
                  <!--Displays "Password" -->
                  <%= f.label :password %> 
             </div>
              <div class="col-sm-8">
                  <!--Displays input box -->
                  <%= f.password_field :password, class:"form-control", placeholder: "Enter password" %> 
             </div>
          </div>    


          <div class="form-group">
            <div class="col-sm-10 col-xs-offset-2">
                <!--Creates a submit button -->
                <%= f.submit "Sign up", class:"btn btn-primary btn-lg" %> 
            </div>
          </div>

        <div class="col-xs-4 col-xs-offset-4 text-center">
          [ <%= link_to "All Articles", articles_path %> ]
       </div> 

            <% end %>

       </div>
    </div>

5) Go to users_controller.rb and create new instance variable in the new action:
              
   Type:
   
   def new
    @user = User.new => creates a new user
   end
              
6) Create routes for submit button (2 ways). Go to config/routes.rb:
  
  Type:
  
  Rails.application.routes.draw do
  
  #Root route (/)
  root 'pages#home'
  #About route (/about)
  get '/about', to: 'pages#about'

  #Creates CRUD for articles. Type: rake routes
  resources :articles
  
  #"users" = controller, "new" = action defined in controller
  get 'signup', to: 'users#new'
    
  #First method. #"users" = controller, "create" = action defined in controller
  post 'users', to: 'users#create'
    
  #or 
    
  #Second method. Creates CRUD routes but omits "new" because we already created it
  resources :users, except: [:new]
  
    
7) Go back to users.controller.rb and define a "create" action to connect routes.rb:
    
   def create
     @user = User.new(user_params) => "user_params" needs to be white listed below into a separate method.
     if @user.save => if @user is abled to be saved,
      flash[:success] = "Welcome to the alpha blog #{@user.username}" => shows flash message
      redirect_to articles_path => redirect to "/articles"
     else
      render 'new' => Displays: /signup => if @user is not able to be saved
     end
   end
  
  private
  def user_params
    params.require(:user).permit(:username, :email, :password) => ":user" is the top level key. For example, user.username, user.email, user.password.password
  end


8) Go to UI and go to "/signup" and create a username.8
               
  Type: User.all => checks if user was added to the database

  Push to git hub "Add users from UI"


Editing a User

1) Go to users.controller.rb and add edit action:

   def edit
    @user = User.find(params[:id]) => This finds the users id
   end  


2) Go to views/users and create edit.html.erb:

Copy and paste new.html.erb into here.

Note: Only changes is "Edit your account" and submit button says "Update"


<h1 class="text-center"> Edit your account </h1>

<%= render 'shared/errors', obj: @user %> 

<div class="row">
  <div class='col-xs-12'>

        <%= form_for(@user, :html => {class: "form-horizontal", role: "form"}) do |f| %>
        <div class="form-group">
          <div class="control-label col-sm-2">
              <!--Displays "Username" -->
              <%= f.label :username %> 
          </div>
          <div class="col-sm-8">
              <!--Displays input box, ":title" grabs from  -->
              <%= f.text_field :username, class: "form-control", placeholder: "Enter Username", autofocus: true %>    
          </div>
       </div>

       <div class="form-group">
          <div class="control-label col-sm-2">
              <!--Displays "Email" -->
              <%= f.label :email %> 
         </div>
          <div class="col-sm-8">
              <!--Displays input box -->
              <%= f.email_field :email, class:"form-control", placeholder: "Enter your email" %> 
         </div>
      </div>


       <div class="form-group">
          <div class="control-label col-sm-2">
              <!--Displays "Password" -->
              <%= f.label :password %> 
         </div>
          <div class="col-sm-8">
              <!--Displays input box -->
              <%= f.password_field :password, class:"form-control", placeholder: "Enter password" %> 
         </div>
      </div>    


      <div class="form-group">
        <div class="col-sm-10 col-xs-offset-2">
            <!--Creates a submit button -->
            <%= f.submit "Update", class:"btn btn-primary btn-lg" %> 
        </div>
      </div>

    <div class="col-xs-4 col-xs-offset-4 text-center">
      [ <%= link_to "All Articles", articles_path %> ]
   </div> 

        <% end %>

   </div>
</div>

3) Go to users_controllers.rb and create update action:

  Type:

  def update
    # Go to users/id/edit
    @user = User.find(params[:id]) => This finds users ID
    if @user.update(user_params) => updates the Users account
     flash[:success] = "Your account was updated successfully"
     redirect_to articles_path 
    else
      render :edit
    end
  end

4) Create partial for users/new.html.erb & users/edit.html.erb:

   Note:
   
   #For submit button. If the user is new, show "Sign up" if not show "Update account"
   <%= f.submit(@user.new_record?) ? "Sign up" : "Update account", class:"btn btn-primary btn-lg" %>

   Create _form.html.erb:

    <%= render 'shared/errors', obj: @user %> 

    <div class="row">
      <div class='col-xs-12'>

            <%= form_for(@user, :html => {class: "form-horizontal", role: "form"}) do |f| %>
            <div class="form-group">
              <div class="control-label col-sm-2">
                  <!--Displays "Username" -->
                  <%= f.label :username %> 
              </div>
              <div class="col-sm-8">
                  <!--Displays input box, ":title" grabs from  -->
                  <%= f.text_field :username, class: "form-control", placeholder: "Enter Username", autofocus: true %>    
              </div>
           </div>

           <div class="form-group">
              <div class="control-label col-sm-2">
                  <!--Displays "Email" -->
                  <%= f.label :email %> 
             </div>
              <div class="col-sm-8">
                  <!--Displays input box -->
                  <%= f.email_field :email, class:"form-control", placeholder: "Enter your email" %> 
             </div>
          </div>


           <div class="form-group">
              <div class="control-label col-sm-2">
                  <!--Displays "Password" -->
                  <%= f.label :password %> 
             </div>
              <div class="col-sm-8">
                  <!--Displays input box -->
                  <%= f.password_field :password, class:"form-control", placeholder: "Enter password" %> 
             </div>
          </div>    


          <div class="form-group">
            <div class="col-sm-10 col-xs-offset-2">
                <!--Creates a submit button -->
                <%= f.submit(@user.new_record?) ? "Sign up" : "Update account", class:"btn btn-primary btn-lg" %> 
            </div>
          </div>

        <div class="col-xs-4 col-xs-offset-4 text-center">
          [ <%= link_to "All Articles", articles_path %> ]
       </div> 

            <% end %>

       </div>
    </div>



