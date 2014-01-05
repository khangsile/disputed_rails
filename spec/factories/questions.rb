# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question, :class => 'Question' do
		sequence(:content) { |n| "Question #{n}?" }
  end
end
