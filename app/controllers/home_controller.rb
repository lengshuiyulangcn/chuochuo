class HomeController < ApplicationController
	 before_filter :authenticate_user!
	def index
		@passages=Passage.all		
	end
end
