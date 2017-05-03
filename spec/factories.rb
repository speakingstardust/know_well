FactoryGirl.define do
  factory :order_line_item do
    product nil
    order nil
    amount_required 1
    ordered_at "2017-05-03 10:26:40"
    received_at "2017-05-03 10:26:40"
  end
  factory :order do
    date_created "2017-05-03"
    completed_at "2017-05-03 10:18:27"
  end
  factory :product do
    name "Gloves"
    manufacturer 
    part_number "12345"
    vendor 
    description "Pair of Black Nitril Gloves"
    container "Case"
    unit "pair"
    units_per_container 24
    price_per_container 4.56
    price_per_unit 0.19
    maximum_on_hand 4.0
    minimum_on_hand 1.5
    lead_time 14 
    current_on_hand 2.0
    order_amount 0.0
    category 1
  end
  factory :vendor do
    name "Test Vendor"
    website "vendor.test.com"
    phone "5555555555"
  end
  factory :manufacturer do
    name "Test Manufacturer Name"
    website "manufacturer.test.com"
    phone "5555555555"
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
