require 'open-uri'
require 'nokogiri'
require_relative 'view'
require_relative 'recipe'

class Controller

  def initialize(cookbook)
    @cookbook = cookbook
    @view     = View.new
  end

  def create
    nam = @view.ask_name
    desc = @view.ask_desc
    prep = @view.ask_prep
    recipe = Recipe.new(name: nam, description: desc, prep_time: prep)
    @cookbook.add_recipe(recipe)
  end

  def list
    all_recipes = @cookbook.all
    @view.display(all_recipes)
  end

  def destroy
    list
    which_one = @view.ask_index - 1
    @cookbook.remove_recipe(which_one)
  end

  def import
    # 0. create an array to store the imported recipes
    imported_recipes = []
    # 1. ask user which ingredient he/she wants to search
    ingredient = @view.ask_ingredient
    # 2. interpolate it with the Marmitoon url
    url = "https://www.marmiton.org/recettes/recherche.aspx?aqt=#{ingredient}"
    # 3. Use Nokogiri to get the HTML of the page
    doc = Nokogiri::HTML(open(url), nil, 'utf-8')
    # 4. Define search class
    doc.search('.recipe-card').first(5).each do |card|
      #  - class of the element that holds the recipe title
      name = card.search('.recipe-card__title').text.strip
      #  - class of the element that holds the recipe description
      desc = card.search('.recipe-card__description').text.strip
      #  - class of the element that holds the recipe prep-time
      prep = card.search('.recipe-card__duration__value').text.strip
      # 5. Create an instance with the found values
      recipe = Recipe.new(name: name, description: desc, prep_time: prep)
      # 6. Push it to an array
      imported_recipes << recipe
    end

    # 7. List the created recipes to the user
    @view.display(imported_recipes)
    # 8. Ask which recipe he wants to save
    which_one = @view.ask_index - 1
    # 9. Save the recipe
    @cookbook.add_recipe(imported_recipes[which_one])
  end

end
