# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question, :class => 'Question' do
  	category
  	content 'Lorem ipsum?'
  end
end
