class Api::QuestionsController <  Api::ProtectedResourceController
	before_filter(only: [:user_index]) { authenticate_user }

	def index
		num = 3
		case params[:sort_by]			
		# when "trending"
			# @questions = Question.all.ordered_by_trend
		when "new"
			@questions = Question.all.order(created_at: :desc).page(params[:page]).per(num)
		when "top"
			@questions = Question.all.order(votes_count: :desc).page(params[:page]).per(num)
		else
			@questions = Question.all.ordered_by_trend.page(params[:page]).per(num)
	  end
	end

	def show
		@question = Question.find_by(id: params[:id])
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
