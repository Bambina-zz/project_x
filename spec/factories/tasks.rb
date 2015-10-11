FactoryGirl.define do
  factory :task do
    errand
    name { Faker::Name.name }
    done false
  end
end
