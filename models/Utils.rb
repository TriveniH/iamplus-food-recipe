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
		cards = []
		parsedJson = JSON.parse(response)
		resultCount = parsedJson["ResultCount"]
		title = parsedJson["Title"]
		cuisine = parsedJson["Cuisine"]
		starRating = parsedJson["StarRating"]
		imageURL = parsedJson["PhotoUrl"]

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
		 cards << create_card_object(title, title, cuisine != nil ? "Cuisine: "+cuisine :cuisine , starRating != nil ? "StarRating: "+starRating.to_s : nil , "", imageURL, extraData, nil)

		 #generate instruction card
		 instructions_cards = generate_instruction_card(instructions, imageURL)
		 instructions_cards.each do | instructions_card|
		 	cards << instructions_card
		 end
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

	def Utils.create_card_object(cardSpeakOut, title, subTitle1, subtitle2, cardSpeakOutLong, imageURL, extraData, longDesc)
        card_object = Card.new
        card_object.set_skillProcessTime 0.44
        card_object.set_speakOut(cardSpeakOut, cardSpeakOutLong, nil, nil)
        card_object.set_card_titles(title, subTitle1, subtitle2)
        card_object.set_longDesc longDesc
        card_object.set_imageUrl imageURL
        card_object.set_extraData extraData
        return card_object
    end

    def Utils.generate_instruction_card(instructions, imageURL)
    	cards = []
    	index = 0
    	instructions.each_line{ |s|
    		s = s.chop
    		if s.to_s.strip.length > 0
				p s
				cardSpeakOut = s
				if index == 0
					cardSpeakOut = "Here's how you make it. "
					cardSpeakOut =  cardSpeakOut + s
				end
				index = 1
				cards << create_card_object(cardSpeakOut, s, nil, nil, nil ,imageURL, nil, nil)
			end
    	}
    	cards
    end
end