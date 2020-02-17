class RecipeView
  def display(recipes)
    recipes.each_with_index do |recipe, index|
      puts "#{index + 1}. #{recipe.marked ? '[x]' : '[ ]'} #{recipe.name.upcase} (#{recipe.prep_time})"
      puts "Difficulty: #{recipe.difficulty}"
      puts recipe.description
      puts "_______________________________________"
    end
  end

  def ask_user_for_recipe_name
    puts "What is the name of the recipe?"
    print ">"
    return gets.chomp
  end

  def ask_user_for_recipe_description
    puts "What is the description of the recipe?"
    print ">"
    return gets.chomp
  end

  def ask_user_for_prep_time
    puts "What is the prep time of the recipe?"
    print ">"
    return gets.chomp
  end

  def ask_user_for_difficulty
    puts "What is the difficulty level of the recipe?"
    print ">"
    return gets.chomp
  end

  def ask_user_for_index
    puts "Which recipe number?"
    print ">"
    return gets.chomp.to_i - 1
  end

  def ask_user_for_keyword
    puts "What ingredient would you like a recipe for?"
    print ">"
    ingredient = gets.chomp
    puts "Looking for #{ingredient} recipes on the Internet... "
    return ingredient.downcase
  end

  def display_search_results(results)
    results.each_with_index do |result, index|
      puts "#{index + 1}. #{result}"
    end
    puts "[...] displaying the top five results"
  end

  def ask_user_for_recipe_to_import
    puts "Which recipe to import? (enter number)"
    print ">"
    return gets.chomp.to_i - 1
  end
end
