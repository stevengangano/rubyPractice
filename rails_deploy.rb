Deploying to heroku

1)  Go "Gemfile"
2)  Cut "sqlite3" from the top
3)  Paste under:
    group :development, :test do
    gem 'sqlite3'
4)  At the very bottom, type:
    
    group :production do
      gem 'pg' => postgres
      gem 'rails_12factor'
    end
5) In the terminal type:

   bundle install --without production

6) Install codeanywhere heroku toolbelt:

   wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh

7) Type: heroku login/password

   stevengangano@yahoo.com/********88

8) Type: heroku create

   This creates an application. For example:

   https://boiling-island-86514.herokuapp.com/ 

9) Commit changes to git

  git add .git
  git commit -m "Deploy the app"
  heroku keys:add

10) If you did not create a SSH key, you can generate
    in the terminal:

    Type: ssh-keygen -t rsa -C "stevengangano@yahoo.com"

11) Git push heroku master

