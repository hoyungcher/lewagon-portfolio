require_relative "meal_repository.rb"
require_relative "employee_repository"
require_relative "customer_repository"
require 'pry-byebug'

class OrderRepository
  def initialize(csv_file, meal_repository, employee_repository, customer_repository)
    @csv_file = csv_file
    @meal_repository = meal_repository
    @employee_repository = employee_repository
    @customer_repository = customer_repository
    @orders = []
    @next_id = 1
    load_csv if File.exist?(csv_file)
  end

  def undelivered_orders
    @orders.select { |order| order.delivered? == false }
  end

  def add(new_order)
    new_order.id = @next_id
    @orders << new_order
    @next_id += 1
    save_changes_to_csv
  end

  def find(order_id)
    @orders.find { |order| order.id == order_id }
  end

  def save_changes_to_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(@csv_file, 'wb', csv_options) do |csv|
      csv << ["id", "delivered", "meal_id", "employee_id", "customer_id"]
      @orders.each do |order|
        csv << [order.id, order.delivered?, order.meal.id, order.employee.id, order.customer.id]
      end
    end
  end

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file, csv_options) do |row|
      id = row[:id].to_i
      delivered = row[:delivered] == "true"
      meal_id = row[:meal_id].to_i
      employee_id = row[:employee_id].to_i
      customer_id = row[:customer_id].to_i
      @orders << Order.new(id: id, delivered: delivered, meal: @meal_repository.find(meal_id), employee: @employee_repository.find(employee_id), customer: @customer_repository.find(customer_id))
      @next_id += 1
    end
  end
end
