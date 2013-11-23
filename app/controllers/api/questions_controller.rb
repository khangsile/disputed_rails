module Api
	class QuestionsController <  Api::ProtectedResourceController

		def index
		end

		def create
			Question.create!(question_params)
		end

		end

		private

		def question_params
			params[:category_id] = Category.find_by!(name: params[:category]) unless params[:category].blank?
			params.permit(:content,:category_id)
		end

	end
end