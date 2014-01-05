require 'spec_helper'

describe "QuestionsController" do

	let(:headers) { {'HTTP_ACCEPT' => 'application/json'} }

	describe "#index" do
		before { FactoryGirl.create_list :question, 5}
		it "should have 5 questions" do
			get_questions
			body = JSON.parse(response.body)
			expect(response).to be_success
			expect(body.length).to eq(5)
		end
	end

	describe "#create" do
		before do
			user = FactoryGirl.create(:user)
			headers['X-AUTH-TOKEN'] = user.authentication_token
		end
		let(:params) { {content: '?', answers: ['yes','no']} }
		it { expect{create_question(params) }.to change(Question,:count).by(1) }
		it { expect{create_question(params) }.to change(Answer,:count).by(2) }
		it "should be success" do
			create_question(params)
			expect(response).to be_success
		end
	end

	describe "#show" do
		context "when user has voted" do
			let(:vote) { FactoryGirl.create :vote }
			it "returns a question with stats" do
				headers['X-AUTH-TOKEN'] = vote.user.authentication_token
				get_question(vote.answer.question)
				body = JSON.parse(response.body)
				expect(body['question']['answered']).to eq(true)
				# expect(body).to include 'hello'
			end
		end
	end

	describe "#answered_questions_index" do
		it "should get all user's answered questions" do
			user = FactoryGirl.create(:user)
			headers['X-AUTH-TOKEN'] = user.authentication_token
			your_votes = FactoryGirl.create_list(:vote, 5, user: user)
			not_your_votes = FactoryGirl.create_list(:vote, 5)
			get_answered_questions(user)
			body = JSON.parse(response.body)
			# expect(body).to eq(1)
			expect(body.length).to eq(5)
		end
	end

end

def get_answered_questions(user)
	get api_answered_questions_path(user), {}, headers
end

def get_question(question)
	get api_question_path(question), {}, headers
end

def get_questions
	get api_questions_path, {}, headers
end

def create_question(params)
	post api_questions_path, params, headers
end