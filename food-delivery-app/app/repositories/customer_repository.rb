require 'csv'
require_relative '../models/customer.rb'

class CustomerRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @customers = []
    @next_id = 1
    load_csv if File.exist?(@csv_file)
  end

  def all
    @customers
  end

  def add(new_customer)
    new_customer.id = @next_id
    @customers << new_customer
    @next_id += 1
    save_changes_to_csv
  end

  def find(customer_id)
    @customers.find { |customer| customer.id == customer_id }
  end

  def save_changes_to_csv
    CSV.open(@csv_file, 'wb') do |csv|
      csv << ["id", "name", "address"]
      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file, csv_options) do |row|
      id = row[:id].to_i
      name = row[:name]
      address = row[:address]
      @customers << Customer.new(id: id, name: name, address: address)
      @next_id = id + 1
    end
  end
end
