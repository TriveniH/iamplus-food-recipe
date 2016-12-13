class RECIPE
	DOMAIN = "http://api2.bigoven.com/"
	ROUTE = "recipes"
	ROUTE2 = "recipe"
	TITLE = "?title_kw="


	def initialize
	end

	def get_recipe(recipeName)
		recipe_url = ROUTE + TITLE + recipeName + "&"
		delimeter = "rpp=1&pg=1&api_key="
		url = recipe_url + delimeter + ENV['BIGOVEN_API_KEY']
		puts "URL = "+url
		#response = make_api_request_for_recipeId url
		recipeId = make_api_request_for_recipeId url
        finalUrl = ROUTE2 + "/" + recipeId.to_s + "?api_key=" + ENV['BIGOVEN_API_KEY']
        puts "final url = "+finalUrl.to_s
		response = make_api_request_for_detail_recipe finalUrl
		response
	end

	def make_api_request_for_recipeId url
		response_back = nil
		recipeId = nil
		api_request_time = Benchmark.realtime do
			request = APIRequest.new( :generic, DOMAIN )
			puts "url:::::"+ url.to_s
			response = request.for( :get, url, '')
			#response_back = JsonUtils.process_response_for_recipes(response.body)
			puts "response = "+response.to_s
			recipeId = JsonUtils.get_highest_rated_recipes(response.body)
			puts "recipeId === "+recipeId.to_s
		end
		puts "api_request_time for recipeId = "+api_request_time.to_s
		recipeId
	end

	def make_api_request_for_detail_recipe url
		response = nil
		api_request_time = Benchmark.realtime do
			request = APIRequest.new( :generic, DOMAIN )
			puts "final url:::::"+ url.to_s
			response = request.for( :get, url, '')
			#response_back = JsonUtils.process_response_for_recipes(response.body)
			puts "response = "+response.to_s
			
		end
		puts "api_request_time for detailed recipe = "+api_request_time.to_s
		response
	end
end