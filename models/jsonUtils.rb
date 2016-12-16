class JsonUtils
	FORMAT_VERSION 	= "1"
	FORMAT 			= "default"
	attr_accessor	:introSpeakOut,
				  	:cardList,
				  	:status,
        			:action,
            		:autoScroll_needed

	def set_introSpeakOut speakOut
		@introSpeakOut = speakOut
	end

	def set_cardList cardList
		@cardList = cardList
   		#check_if_auto_scroll_needed
	end

	def set_status status
		@status = status
	end

    def set_action action
   		 @action = action
    end

    def get_card_data
      cardToken = {stockId:"123"}
      cardsData1 = @cardList.map do |card|
      {name:"FirstCard",
        id:"333-333-333",
        cardToken:"{stockId:123}",
        speakOut:card.cardSpeakOut,
        speakOutLong:card.cardSpeakOut,
        showSpeech:card.cardSpeakOut,
        showSpeechLong:card.cardSpeakOut,
        imageUrl:card.imageUrl,
        backgroundImageUrl:card.imageUrl,
        webviewUrl:card.imageUrl,
        richMediaUrl:"",
        actionButtons:[],
        extraData: card.extraData,
        title:card.cardTitle,
        subtitle1:card.subTitle1,
        subtitle2:card.subTitle2,
        desc:card.cardTitle,
        longDesc:card.cardTitle,
        bgColor:"black",
        location:{ }
        }
      end
    end

    def generate_response_json
      ingredient_list = []
      instruction = ""
      nutritionInfo = {}
      extraData = {
        ingredient_list:"ingredient_list",
        instruction:"instruction",
        nutritionInfo:"nutritionInfo"
      }
		result = {
        "intentToken": "this can be used as a field for global memory",
        "introSpeakOut": introSpeakOut,
        "autoListen": true,
        "autoExpandFirstCard": true,
        "cardsData": get_card_data,
        "extraData":extraData,
      }
      json = { 
          "format": @FORMAT,  
          "formatVersion": @FORMAT_VERSION,
          "status": status ? "FAILED" : "SUCCESS",
          "result": result
      }
	end

end
