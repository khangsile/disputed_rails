require 'spec_helper'

describe "VotesController" do
	
	let(:headers) { {'HTTP_ACCEPT' => 'application/json'} }

	describe "#create" do
		let(:answer) { FactoryGirl.create :answer }
		let(:user) { FactoryGirl.create :user }
		before do
			headers['X-AUTH-TOKEN'] = user.authentication_token
		end

		it "should create vote" do
			expect{create_vote(answer.question,answer)}.to change(Vote, :count).by(1)
			expect(response).to be_success
			expect(response.body).to include('count')
		end

		it "should increase question's vote count" do
			create_vote(answer.question,answer)
			expect{answer.question.reload}.to change(answer.question, :votes_count).by(1)
		end

		it "should increase answer's vote count" do
			create_vote(answer.question,answer)
			expect{answer.reload}.to change(answer,:votes_count).by(1)
		end
	end

end

def create_vote(question,answer)
	post api_question_answer_votes_path(question,answer), {}, headers
end