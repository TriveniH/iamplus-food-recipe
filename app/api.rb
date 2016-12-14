set :raise_errors, true
set :show_exceptions, false

LIMIT = 5

before do
  request.body.rewind
  begin
    @params = JSON.parse( request.body.read, symbolize_names:true )
  rescue
    puts "error parsing the request"
  end
  content_type 'application/json'
end

get '/' do
  {status: "WELCOME TO FOOD-RECIPE!!!!"}.to_json
end

post '/recipe' do
  
  recipe = FoodRecipe.new(get_params)
  response = recipe.get_data.to_json
  return response

end

def get_params
	iterator_index = 1
	  entityFields = Hash.new
  	ps = @params[ :nlu_response ][ :mentions ].map do | h |

=begin
	entity = h[:entity]
    	if entity != nil
          recipeName = entity[:recipe_name]
          if recipeName != nil
      		  entityFields[:recipe_name] = entity[:recipe_name]
          end
    	end
=end

      key = h[:field_id]
      value = h[:value]
      entityFields[key] = value
	end
	 entityFields[:user_id] = @params[:iAmPlusId]
	 puts "entityFields: "+ entityFields.to_s
	 entityFields
end


