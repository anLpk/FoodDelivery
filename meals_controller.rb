require_relative "../models/meal"
require_relative '../views/meal_view'

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @view = MealView.new
  end

  def add
    meal_name = @view.meal_name
    meal_price = @view.meal_price
    meal = Meal.new(name: meal_name, price: meal_price)
    @meal_repository.create(meal)
  end

  def list
    display_meals
  end

  private

  def display_meals
    meals = @meal_repository.all
    @view.display(meals)
  end
end
