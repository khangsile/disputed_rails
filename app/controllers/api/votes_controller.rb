class Api::VotesController <  Api::ProtectedResourceController
	before_filter(only: :create) { authenticate_user }

	def create
		Vote.create!(user_id: current_user.id, question_id: params[:question_id], answer_id: params[:answer_id])
		@answers = Answer.where(question_id: params[:question_id])
		render 'api/answers/index'
	end

end
