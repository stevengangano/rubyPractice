class ArticlesController < ApplicationController
  
  #index page (/articles)
  def index
    @articles = Article.all
  end
  
  #Form to create new article (articles/new)
  def new
    @article = Article.new
  end
  
  #Posts an article from (articles/new)
  def create
    #render plain: params[:article].inspect 
    @article = Article.new(article_params)
    if @article.save 
        flash[:notice] = "Article was successfully created" 
        redirect_to article_path(@article)
    else
      render :new 
    end
  end
  
  #Show page (/articles/:id)
  def show  
     @article = Article.find(params[:id])
  end
  
  #Page to edit (/articles/:id/edit)
  def edit
    @article = Article.find(params[:id])
  end
  
  #Posts the updated article (articles/:id)
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      render :edit
    end
  end
  
  #Delete route (/articles/:id)
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = "Article was successfully deleted"
    redirect_to articles_path         
  end

  
  #method to add data to the database
  private
    def article_params
      params.require(:article).permit(:title, :description) 
    end
 
end