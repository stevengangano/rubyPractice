Creating new Articles from UI

       Note:

       Model > Controller > View
       Db/migrate, Db/schema.rb => Defines what goes into the database

1) Creating "articles/new" route

    1) Go to config/routes.rb

       Type: resources :articles => This adds the CRUD functionality
       
       Type: rake routes => Displays the paths available to you

    2) Create a controller (app/controllers/articles_controller.rb)

       Note: "articles" is plural in "articles_controller.rb" based on the
       model name "article.rb".
  

      Type: 

      class ArticlesController < ApplicationController
         def new => "new" can be named anything you want. Linked with new.html.erb
        
         end
     end

    3) Create an articles folder in views (views/articles)

    4) Create a html.erb file in articles folder (new.html.erb) and add HTML

    5) Go to server and go to "articles/new"

    6) Creating forms in rails, go to:

       guides.rubyonrails.org/form_helpers.html

    7) Go back to new.html.erb
        
       Type:
    
       <%= form_for @article do |f| %>

       <% end %>
         
       Note: "@article" needs to be defined in articles_controller.rb

    8) Go to articles_controller.rb

       Type:

      class ArticlesController < ApplicationController
        def new
           @article = Article.new => "Article" is defined in 
           (models/article.rb). "@article" creates a new article
        end
      end

    9) Go back to new.html.erb (building a form cont.)

       Type:

       <%= form_for @article do |f| %> => @article is defined in articles_controller.rb

        <p>
          <%= f.label :title %> => Displays "title"
          <%= f.text_field :title %> => Displays input box
        </p>
           
        <p>
          #Displays "Description"
          <%= f.label :description %> <br/>
           #Displays input box
           <%= f.text_area :description %> 
        </p>

       <p>
          #Creates a submit button
          <%= f.submit %> 
       </p>
         
       <% end %>
    

  10) Rendering the text entered into the input
        
      1) Go back to articles_controller.rb
   
      Type:

      class ArticlesController < ApplicationController
        def new
          @article = Article.new
        end
  
       def create => Linked with the submit button
          render plain: params[:article].inspect => Displays the data onto the screen
          @article = Article.new(article_params) => "method defined below" to save to database
          @article.save => Saves the article
      end
  
     
     private
        def article_params => Needed to save data to the database
          params.require(:article).permit(:title, :description) => ":article" is 
          the top level key in schema.rb. Permit will allow to 
          post title and description.
        end
 
  
    end

11) Completing "def create" method

class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end
  
  def create => Linked with the submit button
    #render plain: params[:article].inspect 
    @article = Article.new(article_params) => "method defined below" to save to database
    if @article.save => If you are able to save to the database,
        flash[:notice] = "Article was successfully created" => it displays flash message and
        redirect_to article_path(@article) =>, redirect to "/article"
        else
          render :new => if not, render "/article/new". ":new" is method at top.
        end
    end
      
  def show => This is the show page. /articles/:id(.:format). Linked with
     views/articles/show.html.erb   
     @article = Article.find(params[:id])
  end
  
  private
    def article_params
      params.require(:article).permit(:title, :description) => ":article" is 
          the top level key in schema.rb. Permit will allow to 
          post title and description. 
    end
 
end
    
    
12) Displaying the flash message FROM "def create" when SUCCESSFUL. Go to views/layouts/application.html.erb.
  
    Note: Everything in views is wrapped by (views/layouts/application.html.erb)

    <body>
      
      <%= flash.each do |name, msg| %>
        <ul>
          <li> <%= msg %> </li>  
       </ul>
      <% end %>  
 
    </body>

13) Displaying the errors. Go to new.html.erb
  
  #If there are any errors adding "@article",
  <% if @article.errors.any? %>
  <h2>The following errors prevented the article from being created:</h2>
  #For each full message,
  <ul>
  <% @article.errors.full_messages.each do |msg| %>
    #Display the error message
    <li><%= msg %></li>
    <% end %>
  </ul>
  <% end %>


14) Create the show route "def show" in articles_controller.rb

class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end
  
  def create => Linked with the submit button
    #render plain: params[:article].inspect 
    @article = Article.new(article_params) => "method defined below" to save to database
    if @article.save => If you are able to save to the database,
        flash[:notice] = "Article was successfully created" => it displays flash message and
        redirect_to article_path(@article) =>, redirect to "/article"
      else
        render :new => if not, render "/article/new". ":new" is method at top.
      end
   end   
      
  def show => This is the show page. /articles/:id(.:format). Linked with
     views/articles/show.html.erb   
     @article = Article.find(params[:id])
  end
  
  private
    def article_params
      params.require(:article).permit(:title, :description) => ":article" is 
          the top level key in schema.rb. Permit will allow to 
          post title and description. 
    end
 
end
  

15) Create show.html.erb to display show route





       