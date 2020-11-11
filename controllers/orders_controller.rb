require 'pry-byebug'
require_relative "../views/orders_view"
require_relative "../views/meals_view"
require_relative "../views/customers_view"

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository
    @orders_view = OrdersView.new
    @meals_view = MealsView.new
    @customers_view = CustomersView.new
  end

  def add
    # Ask for meal index
    display_meals
    meal_index = @orders_view.ask_for("meal index").to_i - 1
    # Ask for customer index
    display_customers
    customer_index = @orders_view.ask_for("customer index").to_i - 1
    # Ask for employee index
    display_employees
    employee_index = @orders_view.ask_for("employee index").to_i - 1
    # Find meal
    meal = @meal_repository.all[meal_index]
    # Find customer
    customer = @customer_repository.all[customer_index]
    # Find employee
    employee = @employee_repository.all_delivery_guys[employee_index]
    # Create order
    order = Order.new(meal: meal, customer: customer, employee: employee)
    @order_repository.create(order)
  end

  def list_undelivered_orders
    orders = @order_repository.undelivered_orders
    @orders_view.display(orders)
  end

  def mark_as_delivered(employee)
    list_my_orders(employee)
    order_index = @orders_view.ask_for("order index").to_i - 1
    orders = @order_repository.undelivered_orders.select { |order| order.employee == employee }
    order = orders[order_index]
    @order_repository.mark_as_delivered(order)
  end

  def list_my_orders(employee)
    orders = @order_repository.undelivered_orders.select { |order| order.employee == employee }
    @orders_view.display(orders)
  end

  def display_meals
    meals = @meal_repository.all
    @meals_view.display(meals)
  end

  def display_customers
    customers = @customer_repository.all
    @customers_view.display(customers)
  end

  def display_employees
    employees = @employee_repository.all_delivery_guys
    @orders_view.display_employees(employees)
  end
end
