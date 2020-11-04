require "csv"
require_relative "meal"

class MealRepository
  def initialize(csv_file_path)
    @meal_id = 1
    @csv_file_path = csv_file_path
    @meals = []
    load_csv if File.exist?(@csv_file_path)
  end

  def load_csv
    csv_options = { headers: true, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      row[:id] = row[:id].to_i
      row[:name] = row[:name]
      row[:price] = row[:price].to_i
      meal = Meal.new(row)
      @meals << meal
    end
    @meal_id = @meals.size + 1
  end

  def create(meal)
    meal.id = @meal_id
    @meal_id += 1
    @meals << meal
    save_csv
  end

  def all
    return @meals
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << ["name", "id", "price"]
      @meals.each do |meal|
        csv << [meal.name, meal.id, meal.price]
      end
    end
  end

  def find(id)
    @meals.find { |meal| meal.id == id }
  end
end
