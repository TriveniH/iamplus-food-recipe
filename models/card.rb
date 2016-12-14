class Card
	attr_accessor 	:skillProcessTime,
					:introSpeakOut,
					:introSpeakOutLong,
					:introShowSpeech,
					:introShowSpeechLong,
					:cardSpeakOut,
					:imageUrl,
					:cardTitle,
					:subTitle1,
					:subTitle2,
					:extraData


	def set_skillProcessTime processTime
		@skillProcessTime = processTime
	end

	def set_introSpeakOut speakOutText
		@introSpeakOut = speakOutText
		@introShowSpeech = speakOutText
		@introShowSpeechLong = speakOutText
		@introSpeakOutLong = speakOutText
	end

	def set_status queryStatus
		@status = queryStatus
	end

	def set_card_titles(cardTitle, subTitle1, subTitle2)
		@cardTitle = cardTitle
		@subTitle1 = subTitle1
		@subTitle2 = subTitle2
	end

	def set_cardTitle cardTitle
		@cardTitle = cardTitle
	end

	def set_cardSubTitle1 cardTitle
		@subTitle1 = cardTitle
	end

	def set_cardSubTitle2 cardTitle
		@subTitle2 = cardTitle
	end

	def set_imageUrl imageUrl
		@imageUrl = imageUrl
	end

	def set_extraData extraData
		@extraData = extraData
	end

	def set_cardSpeakOut cardSpeakOut
		@cardSpeakOut = cardSpeakOut
	end

	def set_graph_url symbol
    	@imageUrl = "http://ichart.finance.yahoo.com/b?s=#{symbol}&100000"
    end
end