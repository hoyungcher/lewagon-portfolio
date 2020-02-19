require_relative '../repositories/meal_repository.rb'
require_relative '../models/meal.rb'
require_relative '../views/meals_view.rb'
require "pry-byebug"

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meals_view = MealsView.new
  end

  def list
    menu = @meal_repository.all
    @meals_view.display_menu(menu)
  end

  def add
    meal_name = @meals_view.ask_user_for_meal_name
    meal_price = @meals_view.ask_user_for_meal_price.to_i
    @meal_repository.add(Meal.new(name: meal_name, price: meal_price))
  end
end
