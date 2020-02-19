require 'csv'
require_relative '../models/employee.rb'

class EmployeeRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @employees = []
    @next_id = 1
    load_csv if File.exist?(@csv_file)
  end

  def all_delivery_guys
    @employees.select { |employee| employee.role == "delivery_guy" }
  end

  def find(employee_id)
    @employees.find { |employee| employee.id == employee_id }
  end

  def find_by_username(employee_username)
    @employees.find { |employee| employee.username == employee_username }
  end

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file, csv_options) do |row|
      id = row[:id].to_i
      username = row[:username]
      password = row[:password]
      role = row[:role]
      @employees << Employee.new(id: id, username: username, password: password, role: role)
      @next_id += 1
    end
  end
end
