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
		#get long description for the ingredients
		ingradientString =  get_ingredient_data(ingredients)
		ingrdientCard = create_card_object("This is all you need, "+ ingradientString, "Ingredients", nil, nil, ingradientString, imageURL, nil, ingradientString)

		instructions = parsedJson["Instructions"]
		nutritionInfo = parsedJson["NutritionInfo"]
		nutritionInfoString = get_nutritionInfo_data(nutritionInfo)
	    #nutritionInfoCard = create_card_object("Nutrition Facts", "NutritionInfo", nil, nil, nutritionInfoString, imageURL, nil, nutritionInfoString)
		 #cards << nutritionInfoCard

		#generate first card
		puts "-----------------------------------------------------------------------------"
		cards << create_card_object(get_speakOut_for_firstCard(parsedJson), title, cuisine != nil ? "Cuisine: "+cuisine :cuisine , starRating != nil ? "StarRating: "+starRating.to_s : nil , nil, imageURL, nil, nil)
		#add ingredients card.
		cards << ingrdientCard

		#generate instruction card
		instructions_cards = generate_instruction_card(instructions, imageURL)
		instructions_cards.each do | instructions_card|
			cards << instructions_card
		end
		cards
	end

	def Utils.get_ingredient_data(ingredients)
		ingredient_final_string = ""
		ingredients_list  = ingredients.each do | ingredient |
			ingradient = ingredient["Name"] + ", "+ ingredient["DisplayQuantity"] + " "+ingredient["Unit"]
			ingredient_final_string = ingredient_final_string + ingradient + "\n"
		end
		puts ingredient_final_string
		ingredient_final_string
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

	def Utils.get_speakOut_for_firstCard(parsedJson)
		yieldNumber = parsedJson["YieldNumber"]
    	yieldUnit = parsedJson["YieldUnit"]
    	totalMinutes = parsedJson["TotalMinutes"]
    	title  = parsedJson["Title"]
    	nutritionInfo = parsedJson["NutritionInfo"]
    	serving  = nutritionInfo["SingularYieldUnit"]
    	totalCalories  = nutritionInfo["TotalCalories"]
    	longDesc = ". It is " + totalCalories.to_s + " calories for "+ serving.to_s

    	finalResponse = "#{title} will take around "+ totalMinutes.to_s + " minutes for "+ yieldNumber.to_s + " "+ yieldUnit.to_s
    	finalResponse = finalResponse + longDesc

	end

    def Utils.get_long_description_for_first_card(parsedJson)
    	nutritionInfo = parsedJson["NutritionInfo"]
    	serving  = nutritionInfo["SingularYieldUnit"]
    	totalCalories  = nutritionInfo["TotalCalories"]
    	longDesc = "nutritionInfo: \n" + totalCalories.to_s + " calories for "+ serving.to_s
    end

   def Utils.get_nutritionInfo_data(nutritionInfo)
		nutritionInfo_final_string = ""
		singularYieldUnit = nutritionInfo["SingularYieldUnit"]
		totalCalories = nutritionInfo["TotalCalories"]
		totalFat = nutritionInfo["TotalFat"]
		caloriesFromFat = nutritionInfo["CaloriesFromFat"]
		totalFatPct = nutritionInfo["TotalFatPct"]
		satFat = nutritionInfo["SatFat"]
		satFatPct = nutritionInfo["SatFatPct"]
		monoFat = nutritionInfo["MonoFat"]
		polyFat = nutritionInfo["PolyFat"]
		transFat = nutritionInfo["TransFat"]
		cholesterol = nutritionInfo["Cholesterol"]
		cholesterolPct = nutritionInfo["CholesterolPct"]
		sodium = nutritionInfo["Sodium"]
		sodiumPct = nutritionInfo["SodiumPct"]
		potassium = nutritionInfo["Potassium"]
		potassiumPct = nutritionInfo["PotassiumPct"]
		totalCarbs = nutritionInfo["TotalCarbs"]
		totalCarbsPct = nutritionInfo["TotalCarbsPct"]
		dietaryFiber = nutritionInfo["DietaryFiber"]
		dietaryFiberPct = nutritionInfo["DietaryFiberPct"]
		sugar = nutritionInfo["Sugar"]
		protein = nutritionInfo["Protein"]
		proteinPct = nutritionInfo["ProteinPct"]

		nutritionInfo_final_string = "Nutrition Info: \n SingularYieldUnit :" +singularYieldUnit.to_s + "\n" +
									"TotalCalories :" +totalCalories.to_s + "\n" +
									"TotalFat :" +totalFat.to_s + "\n" +
									"CaloriesFromFat :" +caloriesFromFat.to_s+ "\n" +
									"TotalFatPct :" +totalFatPct.to_s + "\n" +
									"SatFat :" +satFat.to_s + "\n" +
									"SatFatPct :" +satFatPct.to_s + "\n" +
									"MonoFat :" +monoFat.to_s + "\n" +
									"PolyFat :" +polyFat.to_s + "\n" +
									"TransFat :" +transFat.to_s + "\n" +
									"Cholesterol :" +cholesterol.to_s + "\n" +
									"CholesterolPct :" +cholesterolPct.to_s + "\n" +
									"Sodium :" +sodium.to_s + "\n" +
									"SodiumPct :" +sodiumPct.to_s + "\n" +
									"Potassium :" +potassium.to_s + "\n" +
									"PotassiumPct :" +potassiumPct.to_s + "\n" +
									"TotalCarbs :" +totalCarbs.to_s + "\n" +
									"TotalCarbsPct :" +totalCarbsPct.to_s + "\n" +
									"DietaryFiber :" +dietaryFiber.to_s + "\n" +
									"DietaryFiberPct :" +dietaryFiberPct.to_s + "\n" +
									"Sugar :" +sugar.to_s + "\n" +
									"Protein :" +protein.to_s + "\n" +
									"ProteinPct :" +proteinPct.to_s
	end
end