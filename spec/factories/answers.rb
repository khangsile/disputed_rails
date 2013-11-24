# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
  	question
  	sequence(:name) { |n| "Answer #{n}?" }
  end
end
