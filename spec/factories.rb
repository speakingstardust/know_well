FactoryGirl.define do
  factory :scope_of_work do
    name "MyString"
    date_created "2017-09-13"
    created_by "MyString"
    description "MyText"
  end
  factory :expense_report do
    user 
    admin nil
    date { Date.today }
    amount 5.50
    vendor "Test Expense Report Vendor"
    category 1
    note "Test Expense Report Note"
    other_note "Other Expense Report Note"
    payment_method 1
    receipt { File.new("#{Rails.root}/spec/support/fixtures/test_pic.jpg") }
  end
  factory :comment do
    creator_name "Test Creator"
    subject "Test Comment Subject"
    comment "This is a test comment for the project tracking system."
  end
  factory :safety_data_sheet do
    product
    pdf { File.new("#{Rails.root}/spec/support/fixtures/SDS_Grate.pdf") }
  end
  factory :category do
    name "Raw Materials"
    product_report nil
  end
  factory :product_report_line_item do
    product_report nil
    product 
    current_amount nil
  end
  factory :product_report do
    date_created { Date.today }
    notes "Product Report Test Note"

    factory :product_report_with_line_items do 
      transient do 
        line_items_count 3
      end

      after(:create) do |product_report, evaluator|
        product_report_line_items = create_list(:product_report_line_item, evaluator.line_items_count, 
                                                product_report: product_report)
        product_report.product_report_line_items << product_report_line_items[1..(evaluator.line_items_count - 1)]
      end
    end
  end
  factory :order_line_item do
    product 
    order nil
    amount_required 6
    ordered_at { Time.now - 3.days }
    received_at nil
  end
  factory :order do
    date_created { Date.today }
    completed_at nil

    factory :order_with_line_items do
      transient do
        line_items_count 3
      end

      after(:create) do |order, evaluator| 
        order_line_items = create_list(:order_line_item, evaluator.line_items_count, order: order)
        order.order_line_items << order_line_items[1..(evaluator.line_items_count-1)]
      end
    end
  end
  factory :product do
    sequence(:name) { |n| "Test Product #{n}" }
    manufacturer 
    part_number "12345"
    vendor 
    location "Test Location"
    description "Pair of Black Nitril Gloves"
    container "Case"
    unit "pair"
    units_per_container 24
    price_per_container 4.56
    price_per_unit 0.19
    maximum_on_hand 72.0
    minimum_on_hand 24.0
    lead_time 14 
    current_on_hand 2.0
    order_amount 0.0
    category
  end
  factory :vendor do
    sequence(:name) { |n| "Test Vendor #{n}" }
    website "vendor.test.com"
    phone "5555555555"
  end
  factory :manufacturer do
    sequence(:name) { |n| "Test Manufacturer #{n}" }
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
    name "Test Project"
    description "Test description for test project."
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
    jig 
    expected 1
    repaired 1
    actual 1
  end
  factory :jig_work_order do
    customer 
    purchase_order "12345"
    notes "Test notes"
    pickup_date { Date.today - 3 }
    returned { Date.today }
    driver "Test Driver Name"
    truck_number "10"
    verified_by nil
    verified_at nil
    completed_by nil
    completed_at nil

    factory :jig_work_order_with_line_items do 
      transient do 
        line_items_count 3
      end

      after(:create) do |jig_work_order, evaluator|
        create_list(:jig_work_order_line_item, evaluator.line_items_count, jig_work_order: jig_work_order)
      end
    end
  end
  factory :admin do
    email "foo@bar.com"
    first_name "Admin"
    last_name "Doe"
    password "password"
    password_confirmation "password"
  end

  factory :role do
    
  end
  factory :customer do
    sequence(:name) {|n| "Test Customer #{n}" }

    factory :customer_with_jig_orders do
      after(:create) do |profile, evaluator|
        create_list(:jig_order, 5, profiles: [profile])
      end
    end
  end

  factory :jig do
    sequence(:name) {|n| "Test Jig #{n}" }
    cleaning_charge 9.50
    repair_charge 6.50 
    customer 
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
