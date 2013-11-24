# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vote do
  	answer
  	user
  	 before(:create) do |vote|
			vote.question_id = vote.answer.question_id	
    end
  end
end
