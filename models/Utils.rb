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
	      process_instructions
	      recipeId
	end

	def Utils.parse_recipeId_for_response(response)
		#puts "response::"+ response.to_s
		cards = []
		parsedJson = JSON.parse(response)
		resultCount = parsedJson["ResultCount"]
		title = parsedJson["Title"]
		cuisine = parsedJson["Cuisine"]
		starRating = parsedJson["StarRating"]
		imageURL = parsedJson["ImageURL"]
		

		 ingredients = parsedJson["Ingredients"]
		 ingredients_list  = ingredients.map do | ingredient |
		 	ingredient_data = get_ingredient_data(ingredient)
		 	ingredient_data
		 end
		 puts "ingredients_list = "+ingredients_list.to_s
		 instructions = parsedJson["Instructions"]
		 nutritionInfo = parsedJson["NutritionInfo"]
		 extraData = get_extraData(ingredients_list, instructions, nutritionInfo)
		 puts "-----------------------------------------------------------------------------"
		 puts "extraData = "+extraData.to_s
		 cards << create_card_object(title, cuisine != nil ? "Cuisine: "+cuisine :cuisine , starRating != nil ? "StarRating: "+starRating.to_s : nil , imageURL, extraData)
		 cards
	end

	def Utils.get_ingredient_data(ingredient)
		{
			name:ingredient["Name"],
			quantity:ingredient["DisplayQuantity"],
			unit:ingredient["Unit"]
		}
	end

	def Utils.get_extraData(ingredients_list, instructions, nutritionInfo)
		{
			ingredients_list:ingredients_list,
			instructions:instructions,
			nutritionInfo:nutritionInfo
		}
	end

	def Utils.create_card_object(title, subTitle1, subtitle2, imageURL, extraData)
        card_object = Card.new
        card_object.set_skillProcessTime 0.44
        card_object.set_cardSpeakOut title
        card_object.set_card_titles(title, subTitle1, subtitle2)
        card_object.set_imageUrl imageURL
        card_object.set_extraData extraData
        return card_object
    end

    def Utils.process_instructions
    	instructions = "Line an 8- or 9-inch square pan with foil.  Lightly butter foil; set aside.  In a heavy saucepan, melt chips with sweetened condensed milk and salt.  Remove from heat.  Stir in vanilla and nuts.  Spread evenly into prepared pan.  Chill 2 hours or until firm.  Turn fudge onto cutting board.  Peel off foil and cut into squares.  Store covered in refrigerator."
    	instructions.each_line{|s|
    		s = s.chop
    		if s.to_s.strip.length > 0
				p s
				#create_card_object(s, "", "", "http://redirect.bigoven.com/pics/rs/640/fudgy-dark-chocolate-beet-brow-c284ff.jpg")
			end
    	}
    end
end