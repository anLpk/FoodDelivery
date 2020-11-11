class SessionsView
  def ask_for(label)
    puts "What's for #{label}"
    print "> "
    gets.chomp
  end
end
