Styling

1) Go to app/views/layouts/application.html.erb 

  <%= yield %> => Displays all views

  At the top of body, type:

  <%= render 'layouts/navigation' %>    

2) Create file, views/layouts/_navigation.html.erb

  Copy and paste, bootstrap navbar code in this file => Navbar will display on every 
  page

3) To change color of navbar in scss, go custom.css.scss:

  $navbar-default-bg: black;

  @import "bootstrap-sprockets";
  @import "bootstrap";

  Regular css code goes here, for example:
  .jumbotron {
    color: black;
   }

4) Writing link in embedded ruby code in _navigation.html.erb:

  For example:

  <%= link_to "Alpha blog", root_path, class: "navbar-brand", id: "logo" %>
     
  <li> <%= link_to "Articles", articles_path %> </li>

5) Style home.html.erb:

  <div class="text-center jumbotron">

    <h1>Alpha Blog</h1>
    <p> <%= link_to 'Sign up now', '#', class: "btn btn-primary btn-xlarge", style: 'padding:25px;' %> </p>
    <p><%= link_to 'Blog', articles_path, class: "btn btn-success btn-xlarge" %></p>  

  </div> 
    
6) Style new.html.erb & edit.html.erb with bootstrap in views/articles/_form.html.erb:

   1) Go to bootstrap and look up horizontal forms (under CSS tab)

      Note: Look at bootstrap sample and include use embedded ruby in the _form.html.rb file
     
    For:

    <%= form_for(@article, :html => {class: "form-horizontal", role: "form"}) do |f| %> => Make sure there are no spaces after "form_for"
      
7) Styling the "errors" from _form.html.erb using bootstrap:

         #If there are any errors adding "@article"
        <% if @article.errors.any? %>
        <div class="row">
            <div class="col-xs-8 col-xs-offset-2">
               <div class="panel panel-danger">
                   <div class="panel-heading">
                      <h2 class="panel-title">
                        <%= pluralize(obj.errors.count, "error") %> => If there are multiple errors it will be plural
                        prohbited this article from being saved:
                     </h2>
                     <div class="panel-body">
                       <ul>
                          <% @article.errors.full_messages.each do |msg| %>
                          <li><%= msg %></li>
                          <% end %>
                       </ul>
                     </div>
                   </div>
                </div> 
              </div>       
          </div> 
        <% end %>

8) Create an errors partial by creating a folder/file shared/_errors.html.erb and copy paste the above

9) Go back to _form.html.erb and at the top of page type:

   <%= render 'shared/errors', obj: @article %> => obj = @article in _errors.html.erb
           
10) Go to shared/_errors.html.erb. Change "@article" to "obj" b/c ??????
                     
        #If there are any errors adding an article
        <% if obj.errors.any? %>
        <div class="row">
            <div class="col-xs-8 col-xs-offset-2">
               <div class="panel panel-danger">
                   <div class="panel-heading">
                      <h2 class="panel-title">
                        <%= pluralize(obj.errors.count, "error") %> => If there are multiple errors it will be plural
                        prohbited this article from being saved:
                     </h2>
                     <div class="panel-body">
                       <ul>
                          <% obj.errors.full_messages.each do |msg| %>
                          <li><%= msg %></li>
                          <% end %>
                       </ul>
                     </div>
                   </div>
                </div> 
              </div>       
          </div> 
        <% end %>


11) Styling flash messages. layouts/_flashMessages.html.erb
                    

<div class="row">
  <div class="col-xs-10 col-xs-offset-1">

  <%= flash.each do |name, msg| %> =>
    <div class='alert alert-<%= "#{name}" %>'> => name can be ":success, :danger, etc." from articles_controller.rb
      <a href="#" class="close" data-dismiss="alert"> &#215; </a>  => button to close flash message 
      <%= content_tag :div, msg, :id => "flash_#{name}" if msg.is_a?(String) %> => This displays the message
    </div>
    
    <% end %>
    
  </div>
</div>

For example, in articles_controller.rb:
      
  #Delete route (/articles/:id)
  def destroy
#     @article = Article.find(params[:id])
    @article.destroy
    flash[:danger] = "Article was successfully deleted" => :danger = name
    redirect_to articles_path         
  end


   
  