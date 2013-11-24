class Api::QuestionsController <  Api::ProtectedResourceController
	before_filter(only: [:user_index]) { authenticate_user }

	def index
		@questions = Question.all		
	end

	def show
		@question = Question.find_by(id: params[:id])
		# logger.info current_user.to_yaml
		# logger.info @question.to_yaml
		if !current_user.nil? && Vote.find_by(user_id: current_user.id, question_id: params[:id])
			render 'api/questions/question_with_stats'
		else
			render 'api/questions/question'
		end		
	end

	def create
		@question = Question.create!(question_params)
		params[:answers].each do |answer|
			Answer.create!(question_id: @question.id, name: answer)
		end
	end

	def user_index
		@questions = current_user.questions
		render 'api/questions/index'
	end

	private

	def question_params
		params[:category_id] = Category.find_by!(name: params[:category]) unless params[:category].blank?
		params.permit(:content,:category_id)
	end

end
