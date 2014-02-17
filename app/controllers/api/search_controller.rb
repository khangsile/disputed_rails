class Api::SearchController < Api::ProtectedResourceController

	def create
		@questions = Question.search search_params
		render 'api/questions/index'
	end

	private

	def search_params
		params.permit(:query)
	end

end