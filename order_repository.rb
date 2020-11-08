require "csv"
require_relative "../models/order"
require 'pry-byebug'
# (orders_csv_path, meal_repository, customer_repository, employee_repository)

class OrderRepository
  def initialize(csv_file_path, meal_repository, customer_repository, employee_repository)
    @order_id = 1
    @csv_file_path = csv_file_path
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @orders = []
    load_csv if File.exist?(@csv_file_path)
  end

  def load_csv
    csv_options = { headers: true, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      row[:id] = row[:id].to_i
      row[:delivered] = row[:delivered] == "true"
 
      row[:meal] = @meal_repository.find(row[:meal_id].to_i)
      row[:customer] = @customer_repository.find(row[:customer_id].to_i)
      row[:employee] = @employee_repository.find(row[:employee_id].to_i)
      order = Order.new(row)
      @orders << order
    end
    @order_id = @orders.size + 1
  end

  def create(order)
    order.id = @order_id
    @order_id += 1
    @orders << order
    save_csv
  end

  def save_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.open(@csv_file_path, 'wb', **csv_options) do |csv|
      csv << ['id', 'delivered', 'meal_id', 'customer_id','employee_id']
      @orders.each do |order|
      csv << [order.id, order.delivered?, order.meal.id, order.customer.id, order.employee.id]
        end
    end
  end

  def undelivered_orders
    @orders.select do |order| 
      !order.delivered?
    end
  end
end
