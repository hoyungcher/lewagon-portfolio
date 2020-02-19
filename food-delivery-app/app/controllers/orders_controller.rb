require_relative '../repositories/meal_repository.rb'
require_relative '../repositories/employee_repository.rb'
require_relative '../repositories/customer_repository.rb'
require_relative '../repositories/order_repository.rb'
require_relative '../views/orders_view.rb'
require_relative '../models/order.rb'

class OrdersController
  def initialize(meal_repository, employee_repository, customer_repository, order_repository)
    @meal_repository = meal_repository
    @employee_repository = employee_repository
    @customer_repository = customer_repository
    @order_repository = order_repository
    @orders_view = OrdersView.new
  end

  def list_undelivered_orders
    orders = @order_repository.undelivered_orders
    @orders_view.display_undelivered_orders(orders)
  end

  def add
    @orders_view.display_meals(@meal_repository.all)
    meal = @meal_repository.find(@orders_view.ask_for("meal id").to_i)
    @orders_view.display_customers(@customer_repository.all)
    customer = @customer_repository.find(@orders_view.ask_for("customer id").to_i)
    @orders_view.display_employees(@employee_repository.all_delivery_guys)
    employee = @employee_repository.find(@orders_view.ask_for("employee id").to_i)
    new_order = Order.new(meal: meal, customer: customer, employee: employee)
    @order_repository.add(new_order)
    @orders_view.order_created
  end

  def list_my_orders(employee)
    orders = @order_repository.undelivered_orders. select { |order| order.employee.id == employee.id }
    @orders_view.display_undelivered_orders(orders)
  end

  def mark_as_delivered(employee)
    list_my_orders(employee)
    order_id = @orders_view.ask_for("order id").to_i
    @order_repository.find(order_id) .deliver!
    @order_repository.save_changes_to_csv
  end
end
