require_relative "../models/customer"
require_relative '../views/customer_view'

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @view = CustomerView.new
  end

  def add
    customer_name = @view.customer_name
    customer_address = @view.customer_address
    customer = Customer.new(name: customer_name, address: customer_address)
    @customer_repository.create(customer)
  end

  def list
    display_customer
  end

  private

  def display_customer
    customers = @customer_repository.all
    @view.display(customers)
  end
end
