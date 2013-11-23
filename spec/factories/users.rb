# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	factory :user do
		sequence(:first_name) { |n| "person#{n}" }
		sequence(:last_name) { |n| "person#{n}" }
		sequence(:email) { |n| "person_#{n}@example.com" }
		city 'Lexington'
		state 'Kentucky'
		password "changeme"
		password_confirmation "changeme"
	end
end
