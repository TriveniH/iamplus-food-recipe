class FoodRecipe
	def initialize params
    @recipeName = params[:recipe_name].to_s    
  	end

	 def get_data
	 	puts "recipeName: "+ @recipeName.to_s
	 	recipe = RECIPE.new
	 	recipe.get_recipe(@recipeName.to_s)
	 end

end