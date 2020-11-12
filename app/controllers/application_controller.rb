
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    #binding.pry
    @articles=Article.all
    #test linking pages
    erb :'articles/index'
  end

  get '/articles/new' do
    erb :'articles/new'
  end

  post '/articles' do
    article = Article.create(params)
    redirect "/articles/#{article.id}"
  end

  get '/articles' do
    #should show all of the articles
    @articles = Article.all
    erb :'articles/index'
  end

  get '/articles/:id' do #SHOW
    #displays an individual article
    @article = Article.find_by(id: params[:id])

    if @article
      erb :'articles/show'
    else
      "Whoops! that Article does not exist."
    end
  end

  get '/articles/:id/edit' do
    @article = Article.find_by(id: params[:id])
    #binding.pry
    erb :'articles/edit'
  end

  patch '/articles/:id' do

    article = Article.find_by_id(params[:id])
    article.update(params[:article])

    redirect "/articles/#{article.id}"
  end

  delete '/articles/:id' do #DESTROY
    #binding.pry
    article = Article.find_by_id(params[:id])
    article.destroy

    redirect "/articles"
  end

end
