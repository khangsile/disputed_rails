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
		let(:params) { {content: '?', answers: ['yes','no']} }
		it { expect{create_question(params)}.to change(Question,:count).by(1) }
		it { expect{create_question(params)}.to change(Answer,:count).by(2) }
		it "should be success" do
			create_question(params)
			expect(response).to be_success
			# expect(response.body).to eq('')
		end
	end

end

def get_questions
	get api_questions_path, {}, headers
end

def create_question(params)
	post api_questions_path, params, headers
end