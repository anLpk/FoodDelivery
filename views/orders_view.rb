class OrdersView
  def ask_for(label)
    puts "What's for #{label}"
    print "> "
    gets.chomp
  end

  def display(orders)
    orders.each_with_index do |order, index|
      status = order.delivered? ? "[X]" : "[ ]"
      puts "#{index + 1}. #{status} #{order.meal.name} => #{order.customer.name} | delivery by #{order.employee.username}"
    end
  end

  def display_employees(employees)
    employees.each_with_index do |employee, index|
      puts "#{index + 1}. #{employee.username}"
    end
  end
end
