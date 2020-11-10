# Router
class Router
  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
    @running = true
  end

  def run
    employee = @sessions_controller.sign_in
    while @running
      if employee.manager?
        print_manager_menu
        choice = gets.chomp.to_i
        print `clear`
        route_manager_action(choice)
      else
        print_delivery_guy_menu
        choice = gets.chomp.to_i
        print `clear`
        route_delivery_guy_action(choice, employee)
      end
    end
  end

  private

  def print_manager_menu
    puts '--------------------'
    puts '------- MENU -------'
    puts '--------------------'
    puts '1. Add new meal'
    puts '2. List all meals'
    puts '3. Add new customer'
    puts '4. List all customers'
    puts '5. Add new order'
    puts '6. List undelivered orders'
    puts '8. Exit'
    print '> '
  end

  def print_delivery_guy_menu
    puts "1. list all my undelivered orders"
    puts "2. mark one of my orders as delivered"
    puts "8. Exit"
    print "> "
  end

  def route_manager_action(choice)
    case choice
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list
    when 5 then @orders_controller.add
    when 6 then @orders_controller.list_undelivered_orders
    when 8 then stop!
    else puts 'Try again...'
    end
  end

  def route_delivery_guy_action(choice, employee)
    case choice
    when 1 then @orders_controller.list_my_orders(employee)
    when 2 then @orders_controller.mark_as_delivered(employee)
    when 8 then stop!
    else puts "Try again..."
    end
  end

  def stop!
    @running = false
  end
end
