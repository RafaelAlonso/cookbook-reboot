require 'csv'

class Cookbook

  def initialize(csv_file_path)
    @recipes = []
    @csv_path = csv_file_path
    load
  end

  def add_recipe(recipe)
    @recipes << recipe
    save
  end

  def all
    @recipes
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    save
  end

  def save
    CSV.open(@csv_path, 'wb', col_sep: ',') do |csv|
      csv << ['name', 'description', 'prep_time']
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.prep_time]
      end
    end
  end

  def load
    CSV.foreach(@csv_path, headers: :first_row, header_converters: :symbol) do |row|
      @recipes << Recipe.new(row)
    end
  end

end
