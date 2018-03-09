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

  </div>   ]]]
  
  