FactoryGirl.define do
  factory :jig_order do
    date Date.today
    customer
    jig_order_line_item
  end
end
