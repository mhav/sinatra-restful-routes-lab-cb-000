class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  get '/' do
    erb :index
  end

  get '/recipes' do
    # Show all receipes
    @recipes = Recipe.all
    erb :'recipes/index'
  end

  get '/recipes/new' do
    # Show form to create new recipe
    erb :'recipes/new'
  end

  post '/recipes' do
    recipe = Recipe.create(:name => params[:name],
                           :ingredients => params[:ingredients],
                           :cook_time => params[:cook_time])
    redirect to "/recipes/#{recipe.id}"
  end

  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :'recipes/show'
  end

  delete '/recipes/:id/delete' do
    Recipe.delete(params[:id])
    redirect to '/recipes'
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :'recipes/edit'
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save

    redirect to "/recipes/#{@recipe.id}"
  end

end