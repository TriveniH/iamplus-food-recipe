require 'digest'
require 'securerandom'

module Utils

	def Utils.get_highest_rated_recipes(response)
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

	def Utils.parse_recipeId_for_response(response)
		#puts "response::"+ response.to_s
		parsedJson = JSON.parse(response)
		resultCount = parsedJson["ResultCount"]
		title = parsedJson["Title"]
		cuisine = parsedJson["Cuisine"]
		starRating = parsedJson["StarRating"]
		imageURL = parsedJson["ImageURL"]
		create_card_object(title, "Cuisine: "+cuisine, "StarRating: "+starRating.to_s , imageURL)
		
	end

	def Utils.create_card_object(title, subTitle1, subtitle2, imageURL)
        card_object = Card.new
        card_object.set_skillProcessTime 0.44
        card_object.set_cardSpeakOut title
        card_object.set_card_titles(title, subTitle1, subtitle2)
        card_object.set_imageUrl imageURL
        return card_object
    end    
end