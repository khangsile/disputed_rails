require 'spec_helper'

describe Vote do
  
  it { should respond_to(:user_id) }
  it { should respond_to(:question_id) }
  it { should respond_to(:answer_id) }

  # a user cannot vote more than once for the same question
  context "when user has already voted" do
  	it "is invalid" do
  		vote = FactoryGirl.create :vote
  		bad_vote = FactoryGirl.build(:vote, user: vote.user, question: vote.question, answer: vote.answer)
  		expect(bad_vote).to_not be_valid
  	end
  end
end
