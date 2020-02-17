class Recipe
  attr_reader :name, :description, :prep_time, :difficulty, :marked

  def initialize(name, description, prep_time, difficulty, marked = false)
    @name = name
    @description = description
    @prep_time = prep_time
    @difficulty = difficulty
    if marked == "true" || marked == true
      @marked = true
    else
      @marked = false
    end
  end

  def mark_or_unmark
    @marked = !@marked
  end
end
