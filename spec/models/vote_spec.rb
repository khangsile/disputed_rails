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

  it "it should increase answer counter" do
  	user = FactoryGirl.create :user
  	answer = FactoryGirl.create :answer
  	Vote.create(user_id: user.id, answer_id: answer.id, question_id: answer.question_id)
  	answer.reload
  	expect(answer.votes_count).to eq(1)
  	expect(answer.question.votes_count).to eq(1)
  end

end
