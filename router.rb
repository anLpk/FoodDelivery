class Router
  def initialize(meals_controller, customers_controller, sessions_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @running = true
  end

  def run
    employee = @sessions_controller.sign_in
    while @running
      if employee.manager?
        print print_menu_manager
        choice = gets.chomp.to_i
        route_action_manager(choice)
      else
        print print_menu_delivery_guy
        choice = gets.chomp.to_i
        route_action_delivery_guy(choice)
      end
    end
  end
 
  private

  def print_menu_manager
    puts "--------------------"
    puts "------- MENU -------"
    puts "--------------------"
    puts "1. Add new meal"
    puts "2. List all meals"
    puts "3. Add new customer"
    puts "4. List all customers"
    puts "8. Sign Out"
    puts "9. Exit"
    print "> "
  end

  def print_menu_delivery_guy
    puts "--------------------"
    puts "------- MENU -------"
    puts "--------------------"
    puts "1. List all meals"
    puts "2. List all customers"
    puts "8. Sign Out"
    puts "9. Exit"
    print "> "
  end

  def route_action_manager(choice)
    case choice
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list
    when 8 then @employee = nil
    when 9 then @employee = nil @running = false
    else puts "Try again..."
    end
  end

  def route_action_delivery_guy(choice)
    case choice
    when 1 then @meals_controller.list
    when 2 then @customers_controller.list
    when 8 then @employee = nil
    when 9 then @employee = nil @running = false
    else puts "Try again..."
  end
  end

  def stop!
    @running = false
  end
end
