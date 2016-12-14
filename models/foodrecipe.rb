class FoodRecipe
	def initialize params
    @recipeName = params["recipe_name"].to_s
    @recipeIncl = params["recipe_incl"].to_s
    @recipeExcl = params["recipe_excl"].to_s
    print params
  	end

	 def get_data
	 	puts "recipeName: "+ @recipeName
	 	#process_incl_excl
	 	recipe = RECIPE.new
	 	recipe.get_recipe(@recipeName, process_incl_excl(@recipeIncl), process_incl_excl(@recipeExcl))
	 end

	 def process_incl_excl recipeExcl
	 	finalList1 = []
	 	puts "recipe_excl::"+ recipeExcl.to_s
	 	elements = recipeExcl.split(",")
	 	puts "elements.length:: "+ elements.length.to_s
	 	elements.delete_if{|e| e.length == 0}
	 	# Remove empty elements from the array.
	 	if elements.length >0
	 		elements.each do |element|
	 			secondSplitElements = element.split("and")
	 			puts "second split length::"  +secondSplitElements.length.to_s
	 			if secondSplitElements.length >0
	 				secondSplitElements.each do |secondSplitElement|
	 					temp = secondSplitElement.squish
	 					temp.force_encoding "utf-8"
	 					temp.encode("utf-8", :invalid => :replace)
	 					finalList1 << temp
	 				end
	 			else
 					temp = element.squish
					temp.force_encoding "utf-8"
					temp.encode("utf-8", :invalid => :replace)
	 				finalList1 << temp
	 			end
	 		end
	 	end
	 	puts "finalList1"+ finalList1.to_s
	 	finalList1
	 end

end