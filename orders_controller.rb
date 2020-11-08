require_relative "../views/orders_view.rb"
require_relative "../views/customer_view.rb"
require_relative "../views/sessions_view.rb"
require 'pry-byebug'

class OrdersController
  def initialize(order_repository, meal_repository, customer_repository, employee_repository)
    @order_repository = order_repository
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @view = OrdersView.new
    @meal_view = MealView.new
  end

  def add
    meal_name = @meal_repository.all
    @meal_view.display(meal_name)
    meal = meal_name[@view.ask_for_index]

    customer_name = @customer_repository.all
    @customer_view.display(customer_name)
    customer = customer_name[@view.ask_for_index]

    employee_name = @employee_repository.all_delivery_guys
    @employee_view.display(employee_name)
    employee = employee_name[@view.ask_for_index]

    order = Order.new(meal: meal, customer: customer, employee: employee)
    @order_repository.create(order)
  end
end
