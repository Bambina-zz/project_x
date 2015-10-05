FactoryGirl.define do
  factory :task do
    errand
    name { Faker::Name.name }
    done false
  end

  factory :errand do
    name { Faker::Name.name }
    owner_id { Faker::Number.number(2) }
    shared_hash { Faker::Number.number(10) }

    factory :errand_with_tasks do
      transient do
        tasks_count 3
      end

      after(:create) do |errand, evaluator|
        create_list( :task, evaluator.tasks_count, errand: errand )
      end
    end
  end

  factory :user do
    name  { Faker::Name.name }
    email { Faker::Internet.email }
    password "123456"
    password_confirmation "123456"
  end
end
