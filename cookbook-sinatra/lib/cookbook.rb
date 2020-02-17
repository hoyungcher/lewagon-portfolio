require 'csv'

class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []
    parse_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(@csv_file_path, 'wb', csv_options) do |csv|
      @recipes.each do |saved_recipe|
        csv << [saved_recipe.name, saved_recipe.description, saved_recipe.prep_time, saved_recipe.difficulty, saved_recipe.marked]
      end
    end
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(@csv_file_path, 'wb', csv_options) do |csv|
      @recipes.each do |saved_recipe|
        csv << [saved_recipe.name, saved_recipe.description, saved_recipe.prep_time, saved_recipe.difficulty, saved_recipe.marked]
      end
    end
  end

  def mark_recipe(recipe_index)
    @recipes[recipe_index].mark_or_unmark
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(@csv_file_path, 'wb', csv_options) do |csv|
      @recipes.each do |saved_recipe|
        csv << [saved_recipe.name, saved_recipe.description, saved_recipe.prep_time, saved_recipe.difficulty, saved_recipe.marked]
      end
    end
  end


  def parse_csv
    CSV.foreach(@csv_file_path) do |row|
      @recipes << Recipe.new(row[0], row[1], row[2], row[3], row[4])
    end
  end
end
