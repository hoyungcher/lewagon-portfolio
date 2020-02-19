class MealsView
  def display_menu(menu)
    menu.each do |meal|
      puts "#{meal.id}. #{meal.name} ($#{meal.price})"
    end
  end

  def ask_user_for_meal_name
    puts "What is the meal name?"
    return gets.chomp
  end

  def ask_user_for_meal_price
    puts "What is the meal price?"
    return gets.chomp
  end

end
