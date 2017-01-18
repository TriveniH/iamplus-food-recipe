describe 'API Spec' do
  let( :mentions   ){[ { "field_id": "recipe_name",
                          "value": "chocolate mousse" },
                        { "field_id": "recipe_excl",
                          "value": "cheese, milk and carrot cake" } ]}
  let( :params ){{ nlu_response:{
                     mentions:mentions,
                     intent:'recipe', },
                   user_data:{} }}

  let( :expected  ){{ name:'KazuNori', image_url:'https://s3-media3.fl.yelpcdn.com/bphoto/9D63gCmIesyBQO15NNG9Xw/ms.jpg' }}
  let( :cache_key ){ 'search-los angeles-sushi-5' }

  let( :token        ){ 'abc123'   }
  let( :user_uuid    ){ 'user-1234' }
  let( :identity_url ){ "#{ Identity::IDENTITY_DOMAIN }#{ Identity::IDENTITY_PATH }"}

  let( :business_from_yelp ){ JSON.parse( yelp_response, symbolize_names:true )[ :businesses ][ 0 ]}

  before do
    header 'Content-Type', 'application/json'

   stub_recipe
  
    WebMock.stub_request( :get, identity_url )
      .with( body:"access_token=#{ token }")
      .to_return( status:    200,
                  headers:{ 'Content-Type' => 'application/json' },
                  body:   {  user_uuid:user_uuid }.to_json        )   

  end


  describe 'Recipe' do

    context 'with valid recipe name' do
      specify 'when detail of recipe available for the recipeId' do
        post '/recipe', params.to_json
        puts "last_response:"+ last_response.to_s
        cardsData = parsed_response[ :result ][  :cardsData ]
        expect( last_response.status).to eq 200
        expect( cardsData.length ).to be > 1
        expect( cardsData[0][:imageUrl]).not_to be_nil
        expect( cardsData[0][:title] ).to eq "Dark Chocolate Mousse"
        expect(  cardsData[1][:speakOut]).not_to be_nil
        expect(  cardsData[1][:title]).to eq "Ingredients"
        expect(  cardsData[2][:speakOut]).not_to be_nil
        expect(  cardsData[2][:title]).to eq "METHOD"
      end
    end
  end
end