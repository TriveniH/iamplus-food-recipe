module JsonUtils

	def JsonUtils.get_highest_rated_recipes(response)
		#puts "response::"+ response.to_s
		parsedJson = JSON.parse(response)
		resultCount = parsedJson["ResultCount"]
		results = parsedJson["Results"]
		recipeId = nil
		title = nil 
		
		starRating = nil 
		higest_rated = 0

	      results.each do | result |	   
	      	starRating = result["StarRating"]
	      	
	      	if starRating >= higest_rated
	      		higest_rated = starRating
	      		recipeId = result["RecipeID"]
	      		title = result["Title"]
	      	end

	      end
	      recipeId
	end

end
