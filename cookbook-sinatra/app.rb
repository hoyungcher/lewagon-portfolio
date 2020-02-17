require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require "csv"

require_relative "lib/cookbook.rb"
require_relative "lib/recipe.rb"


configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  csv_file = File.join(__dir__, 'lib/recipes.csv')
  @cookbook = Cookbook.new(csv_file)
  erb :index
end

get '/new' do
  erb :new
end

post '/new' do
  @name = params["name"]
  @description = params["description"]
  @prep_time = params["prep_time"]
  @difficulty = params["difficulty"]
  csv_file = File.join(__dir__, 'lib/recipes.csv')
  cookbook = Cookbook.new(csv_file)
  cookbook.add_recipe(Recipe.new(@name, @description, @prep_time, @difficulty, false))
  "Recipe added!"
  redirect "/"
end

get '/remove' do
  @number = params["number"]
  csv_file = File.join(__dir__, 'lib/recipes.csv')
  cookbook = Cookbook.new(csv_file)
  cookbook.remove_recipe(@number)
  redirect "/"
end

set :bind, '0.0.0.0'
