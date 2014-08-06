class HomeController < ApplicationController
	 before_filter :authenticate_user!
	def index
		@passages=Passage.all.order("last_translated_at DESC")		
	end
	def show_consern
	end
end
