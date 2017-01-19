FactoryGirl.define do
  factory :customer do
    add_attribute(:name) { "Test Customer" }

    factory :customer_with_jig_orders do
      after(:create) do |profile, evaluator|
        create_list(:jig_order, 5, profiles: [profile])
      end
    end
  end

  factory :jig do
    sequence(:name) {|n| "Test Jig #{n}" }
  end

  factory :jig_order do
    date { Date.today }
    jig_order_line_item
  end

  factory :jig_order_line_item do
    jig
  end

  factory :user do
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"
    confirmed_at { Date.today }
  end
end
