# Employee Model
class Employee
  attr_accessor :id
  attr_reader :username, :password, :role

  def initialize(attributes = {})
    @id = attributes[:id]
    @username = attributes[:username]
    @password = attributes[:password]
    @role = attributes[:role]
  end

  def delivery_guy?
    @role == "delivery_guy"
  end

  def manager?
    # @role == "manager"
    !delivery_guy?
  end
end
