require_relative '../repositories/customer_repository.rb'
require_relative '../models/customer.rb'
require_relative '../views/customers_view.rb'

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customers_view = CustomersView.new
  end

  def list
    customers = @customer_repository.all
    @customers_view.display_customers(customers)
  end

  def add
    customer_name = @customers_view.ask_user_for_customer_name
    customer_address = @customers_view.ask_user_for_customer_address
    @customer_repository.add(Customer.new(name: customer_name, address: customer_address))
  end
end
