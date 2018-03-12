Association: 

When an article is created by a user, the database saves the user's ID for that particular article.

******Test App******

1) Create User scaffold

   Type:

   rails generate scaffold User username:string email:string 

   Note: This creates a table file with user and email inside db/migrate.
   Also this creates model/user.rb, users_controllers.rb with CRUD routes. Scaffold creates CRUD routes.


2) Type: rake db:migrate => This creates a schema.rb file

3) Destroying scaffold: rails destroy scaffold User

4) Creating a user in the console:

  Type: rails console
  Type: User => Displays what key:values will be created for each User
  Type: user = User.create(username: "Jack", email: "Jack@example.com") => Creates username


1) Create Comment scaffold

  rails generate scaffold Comment description:text user:references

  Note: "user: references" stores a foreign_Key. foreign_key is the key created
  when a user creates a particular article.

2) Type: db:migrate => Updates the schema.rb file
  
3) Building the association between User and Comment

  Go to models/comment.rb:

  class Comment < ActiveRecord::Base
    belongs_to :user => This shows here because we created "user: references"
  end


  Go to model/user.rb and type:

  class User < ActiveRecord::Base
   has_many :comments => This allows associations between user and comment
  end

4) Creating a comment in the console:

   Type: user = User.first => This grabs the user created 
   Type: user.comments => This shows comments created by the user
   Type: comment = Comment.new(description: "This is a new comment", User: user)

   Note: "user" in User: user" adds the user id for that comment

   Type: comment.save => This saves the comment to the database
   Type: user = User.first => This reloads the user 
   Type: user.comments => Displays the newly created comment

*****Blog App*****

1) Go back to blog app. Leave master branch and create a new branch.
  
   Type: git checkout -b create-users => Creates a branch called "create-users". This creates a copy of the master branch.
   Type: git branch => Displays all branches available to me
   Type: git checkout create-users => Switches to "create-users" branch
   Type: rails generate migration create_users => Creates a table in db/migrate

   Go to Create_Users migration file and type:

    class CreateUsers < ActiveRecord::Migration
    def change
      create_table :users do |t|
        t.string :username => Creates username
        t.string :email => Creates email
        t.timestamps => Creates time 
      end
    end
  end

  Type: rake db: migrate => updates the schema.rb file

2) Create models/user.rb file

   Type:

   class User < ActiveRecord::Base
   end

3) Go to rails console and check if User database was created:

   Type: User.all => Check to see if User database was created
   Type: User => displays table created for each user created
   
4) Creating a user from the console:

   Type: user = User.create(username: "Stebs", email: "stebs@example.com")
  
5) Updating the email:

   Type: Users.all => Displays all users  
   Type: user = User.find(1) => This grabs the user with an ID of 1
   Type: user => Displays which user you are working on
   Type: user.email = "steboogie@gmail.com" 
   Type: user.save => Saves new email to database

6) Destroying the user:

   Type: user = User.find(1)
   Type: user.destroy
   Type: User.all => check if user was deleted

7) Pushing create-user branch to github and merging with master:

   Type: git add .
   Type: git commit -m "create user migration file and user model file"
   Type: git checkout master => migration file and model file are not there
   Type: git merge create-users => migrations file and model file are now on master branch

8) Since create-users branch is now merged with master, we can delete create-users brnach

   Type: git branch => shows available branches
   Type: git branch -d create-users => "-d" will work because we merge create-users with master. If not we would need to use "-D"

9) Push changes to github

   Type: git push

  
1) Creating user validations => models/user.rb

  Type: git checkout -b user-validations => creates a new branch
  
2) Go to models/user.rb

   Go to guides.rubyonrails.org/active_record_validations.html => shows list of validation helpers on right side
  
   Type:

   class User < ActiveRecord::Base
    validates :username, presence: true, uniqueness: { case_sensitive: false },  length: { minimum: 3, maximum: 25 } => presence ensures name is present. "case_sensitive: false" ensures same username such "Stebs" and "stebs" cannot be added
   end


   Type: rails console  
   Type: reload!
    
3) Create a user through console:

   Type: user = User.new(username: "steven", email: "steven@yahoo.com")
   Type: user.save

4) Checking for error messages and correcting, for example:

   Type: user2 = User.new(username: "s", email: "steven@yahoo.com")
   Type: user2.save => Will not allow b/c it "username" is less than 3 characters
   Type: user2.errors.full_messages => shows error messages
   Type: user2 => shows user you are working on
   Type: user2.username = "stebooogie"
   Type: user2.valid? => checks with model/user.rb if valid
   Type: user2.save
   Type. User.all

5) Creating email validations. Go views/user.rb
    
   class User < ActiveRecord::Base
    validates :username, presence: true, 
              uniqueness: { case_sensitive: false },  
              length: { minimum: 3, maximum: 25 } 

    NOTE: presence ensures name is present. "case_sensitive: false" ensures same username such "Stebs" and "stebs" cannot be added
    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, 
              length: { maximum: 105 },
              uniqueness: { case_sensitive: false },
              format: { with: VALID_EMAIL_REGEX } => checks if email valid
  end


   Type: user3 = User.new(username: "Steboogie", email: "steven@.com")
   Type: user3.save => Will not allow b/c email is invalid
   Type: user3.errors.full_messages => shows error messages
   Type: user3 => shows user you are working on
   Type: user3.email = "stebooogie@yahoo.com"
   Type: user3.valid? => checks with model/user.rb if valid. If true, user3.save.
   Type: user3.save
   Type. User.all








  


   



