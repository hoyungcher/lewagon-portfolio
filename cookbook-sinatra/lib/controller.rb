require_relative 'recipe'
require_relative 'recipe_view'
require 'nokogiri'
require 'open-uri'



class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = RecipeView.new
  end

  def list
    display_recipes
  end

  def create
    name = @view.ask_user_for_recipe_name
    description = @view.ask_user_for_recipe_description
    prep_time = @view.ask_user_for_prep_time
    difficulty = @view.ask_user_for_difficulty
    recipe = Recipe.new(name, description, prep_time, difficulty, false)
    @cookbook.add_recipe(recipe)
  end

  def destroy
    display_recipes
    recipe_index = @view.ask_user_for_index
    @cookbook.remove_recipe(recipe_index)
  end

  def import
    keyword = @view.ask_user_for_keyword
    # file = 'strawberry.html'
    # doc = Nokogiri::HTML(File.open(file), nil, 'utf-8')
    url = "https://www.bbcgoodfood.com/search/recipes?query=#{keyword}"
    doc = Nokogiri::HTML(open(url), nil, 'utf-8')
    title_results = []
    doc.css("h3[class='teaser-item__title']").first(5).each do |article|
      title_results << article.text.strip
    end
    description_results = []
    doc.css("div.field-item.even").first(5).each do |article|
      description_results << article.text.strip
    end
    prep_time_results = []
    doc.css("li.teaser-item__info-item.teaser-item__info-item--total-time").first(5).each do |article|
      prep_time_results << article.text.strip
    end
    difficulty_results = []
    doc.css("li.teaser-item__info-item.teaser-item__info-item--skill-level").first(5).each do |article|
      difficulty_results << article.text.strip
    end
    @view.display_search_results(title_results)
    index_number = @view.ask_user_for_recipe_to_import
    @cookbook.add_recipe(Recipe.new(title_results[index_number], description_results[index_number], prep_time_results[index_number], difficulty_results[index_number], false))
  end

  def mark
    display_recipes
    recipe_index = @view.ask_user_for_index
    @cookbook.mark_recipe(recipe_index)
  end

  private

  def display_recipes
    recipes = @cookbook.all
    @view.display(recipes)
  end
end
