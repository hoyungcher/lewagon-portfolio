class OrdersView
  def ask_for(input)
    puts "What is the #{input}?"
    input = gets.chomp
  end

  def display_undelivered_orders(orders)
    orders.each do |order|
      puts "#{order.id}. #{order.customer.name} (#{order.customer.address}) - #{order.meal.name}"
    end
  end

  def order_created
    puts "Order created!"
  end

  def display_meals(meals)
    meals.each do |meal|
      puts "#{meal.id}. #{meal.name} ($#{meal.price})"
      puts "---------------------------------"
    end
  end

  def display_customers(customers)
    customers.each do |customer|
      puts "#{customer.id}. #{customer.name} - (#{customer.address})"
      puts "---------------------------------"
    end
  end

  def display_employees(employees)
    employees.each do |employee|
      puts "#{employee.id}. #{employee.username.capitalize} - (#{employee.role})"
      puts "---------------------------------"
    end
  end
end
