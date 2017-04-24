FactoryGirl.define do
  factory :manufacturer do
    name "Test Manufacturer Name"
    website "manuacturer.test.com"
    phone "555-555-5555"
  end
  factory :progress_note do
    project nil
    note "MyText"
    created_by "MyString"
  end
  factory :task do
    project nil
    start_date "2017-04-04"
    end_date "2017-04-04"
    duration 1
    name "MyString"
    description "MyText"
    completed false
    user_id 1
    percent_complete 1
  end
  factory :project do
    user nil
    name "MyString"
    description "MyText"
    status 1
    department 1
  end
  factory :signature do
    name "MyString"
    signature "MyText"
    signed_on "2017-03-15 14:46:21"
    jig_work_order nil
    type ""
  end
  factory :jig_work_order_line_item do
    jig nil
    jig_work_order nil
    expected 1
    repaired 1
    actual 1
  end
  factory :jig_work_order do
    customer nil
    purchase_order "MyString"
    notes "MyText"
    pickup "2017-03-06 10:16:03"
    returned "2017-03-06"
    verified false
    verified_by "MyString"
    verified_at "2017-03-06 10:16:03"
  end
  factory :admin do
    
  end
  factory :role do
    
  end
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
  end

  factory :jig_order_line_item do
    jig
  end

  factory :user do
    email "foo@bar.com"
    first_name "John"
    last_name "Doe"
    password "password"
    password_confirmation "password"
  end

  factory :report do
    customer
    date_from { Date.today - 7 }
    date_to { Date.today }
  end

  factory :report_line_item do
    jig
  end

end
