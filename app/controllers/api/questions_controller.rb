class Api::QuestionsController <  Api::ProtectedResourceController
	# before_filter(only: :create) { authenticate_user }

	def index
		@questions = Question.all
	end

	def create
		@question = Question.create!(question_params)
		params[:answers].each do |answer|
			Answer.create!(question_id: @question.id, name: answer)
		end
	end

	private

	def question_params
		params[:category_id] = Category.find_by!(name: params[:category]) unless params[:category].blank?
		params.permit(:content,:category_id)
	end

end
