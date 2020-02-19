require 'csv'
require_relative '../models/meal.rb'

class MealRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @meals = []
    @next_id = 1
    load_csv if File.exist?(@csv_file)
  end

  def all
    @meals
  end

  def add(new_meal)
    new_meal.id = @next_id
    @meals << new_meal
    @next_id += 1
    save_changes_to_csv
  end

  def save_changes_to_csv
    # csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(@csv_file, 'wb') do |csv|
      csv << ["id", "name", "price"]
      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end

  def find(meal_id)
    @meals.find { |meal| meal.id == meal_id }
  end

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file, csv_options) do |row|
      id = row[:id].to_i
      name = row[:name]
      price = row[:price].to_i
      @meals << Meal.new(id: id, name: name, price: price)
      @next_id = id + 1
    end
  end
end
