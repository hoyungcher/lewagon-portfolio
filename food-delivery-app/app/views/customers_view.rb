class CustomersView
  def display_customers(customers)
    customers.each do |customer|
      puts "#{customer.id}. #{customer.name} - (#{customer.address})"
    end
  end

  def ask_user_for_customer_name
    puts "What is the customer name?"
    return gets.chomp
  end

  def ask_user_for_customer_address
    puts "What is the customer address?"
    return gets.chomp
  end

end
