# TODO: implement the router of your app.
require_relative 'app/controllers/meals_controller.rb'
require_relative 'app/controllers/customers_controller.rb'
require_relative 'app/controllers/meals_controller.rb'


class Router
  def initialize(meals_controller, customers_controller, orders_controller, employee_repository)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @orders_controller = orders_controller
    @employee_repository = employee_repository
    @running = true
    @logged_in = false
    @user = nil
  end

  def run
    puts "---------------------------------"
    puts "Welcome to the food delivery app!"
    puts "---------------------------------"

    while @running
      login while @logged_in == false
      display_tasks(@user, @user.role)
      action = gets.chomp.to_i
      print `clear`
      route_action(action, @user.role)
    end
  end

  private

  def login
    puts "Please enter your username:"
    print ">"
    username = gets.chomp
    puts "Please enter your password:"
    print ">"
    password = gets.chomp
    employee = @employee_repository.find_by_username(username)
    if employee == nil
      puts "Username doesn't exist"
      puts "Please try again"
      puts "---------------------------------"
    elsif employee.password == password && !employee.nil?
      @logged_in = true
      @user = employee
    else
      puts "Wrong password"
      puts "Please try again"
      puts "---------------------------------"
    end
  end

  def logout
    @logged_in = false
    puts "Bye, #{@user.username.capitalize}! You have successfully logged out!"
    puts "---------------------------------"
    puts "Welcome to the food delivery app!"
    puts "---------------------------------"
  end

  def display_tasks(user, role)
    puts "--------------------------------------------"
    puts "Hi #{@user.username.capitalize}! What do you want to do?"
    puts "--------------------------------------------"
    case role
    when "manager"
      puts "1 - Add a meal"
      puts "2 - View all meals"
      puts "3 - Add a customer"
      puts "4 - View all customers"
      puts "5 - View all undelivered orders"
      puts "6 - Add order and assign to delivery guy"
      puts "7 - Log out"
    when "delivery_guy"
      puts "1 - View undelivered orders"
      puts "2 - Mark order as delivered"
      puts "3 - Log out"
    end
  end

  def route_action(action, role)
    case role
    when "manager"
      case action
      when 1 then @meals_controller.add
      when 2 then @meals_controller.list
      when 3 then @customers_controller.add
      when 4 then @customers_controller.list
      when 5 then @orders_controller.list_undelivered_orders
      when 6 then @orders_controller.add
      when 7 then logout
      else
        puts "Please press 1, 2, 3, 4, 5, 6 or 7"
      end
    when "delivery_guy"
      case action
      when 1 then @orders_controller.list_my_orders(@user)
      when 2 then @orders_controller.mark_as_delivered(@user)
      when 3 then logout
      else
        puts "Please press 1, 2 or 3"
      end
    end
  end

  # def stop
  #   puts "Quitting!"
  #   @running = false
  # end

  # def display_tasks
  #   puts "----------------------------"
  #   puts "What do you want to do next?"
  #   puts "----------------------------"
  #   puts "1 - Display menu"
  #   puts "2 - Add recipe"
  #   puts "3 - Exit"
  # end
end
