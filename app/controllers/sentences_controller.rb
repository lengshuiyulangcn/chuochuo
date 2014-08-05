class SentencesController < ApplicationController
 before_filter :authenticate_user!
  def show
  	@sentence=Sentence.find(params.permit(:id)[:id])
	@translations=@sentence.translations
  end
end
