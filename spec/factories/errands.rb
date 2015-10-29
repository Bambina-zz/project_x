FactoryGirl.define do
  factory :errand do
    name { Faker::Name.name }
    owner_id 1

    factory :errand_with_tasks do
      transient do
        tasks_count 3
      end

      after(:create) do |errand, evaluator|
        create_list( :task, evaluator.tasks_count, errand: errand )
      end
    end
  end
end
