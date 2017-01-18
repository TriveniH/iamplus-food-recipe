
# all stubs related to detailed of recipe
def stub_recipe
  response = File.read( 'spec/shared/bigoven_responses/recipe_list.json' )

	WebMock.stub_request(:get,  %r{http://api2.bigoven.com/recipes+})
        .to_return( status:200,
                    body:  response,
                    headers:{ 'Content-Type': 'application/json' })

  detailed_recipe_response = File.read( 'spec/shared/bigoven_responses/recipe_detail.json' )
  	WebMock.stub_request(:get,  %r{http://api2.bigoven.com/recipe/+})
        .to_return( status:200,
                    body:  detailed_recipe_response,
                    headers:{ 'Content-Type': 'application/json' })

  

end