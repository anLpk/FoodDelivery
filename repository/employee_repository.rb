require "csv"
require_relative "../models/employee"

class EmployeeRepository
  def initialize(csv_file_path)
    @employee_id = 1
    @csv_file_path = csv_file_path
    @employees = []
    load_csv if File.exist?(@csv_file_path)
  end

  def load_csv
    csv_options = { headers: true, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      row[:id] = row[:id].to_i
      row[:username] = row[:username]
      row[:password] = row[:password]
      row[:role] = row[:role]
      employee = Employee.new(row)
      @employees << employee
    end
    @employee_id = @employees.size + 1
  end

  def all_delivery_guys
    @employees.select do |employee|
    employee.delivery_guy?
    end
  end

  def find(id)
    @employees.find { |employee| employee.id == id }
  end

  def find_by_username(username)
    @employees.find { |employee| employee.username == username }
  end
end
