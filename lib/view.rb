class View

  def display(recipes)
    recipes.each_with_index do |recipe, ind|
      puts "#{ind + 1} - #{recipe.name} (#{recipe.prep_time}): #{recipe.description}"
    end
  end

  def ask_ingredient
    puts "give the foken ingredient you wann search"
    return gets.chomp
  end

  def ask_name
    puts "give the foken name of the foken ressaipe"
    return gets.chomp
  end

  def ask_prep
    puts "give the foken prep of the foken ressaipe"
    return gets.chomp
  end

  def ask_desc
    puts "give the foken description of the foken ressaipe"
    return gets.chomp
  end

  def ask_index
    puts "give the foken index of the foken ressaipe"
    return gets.chomp.to_i
  end
end
