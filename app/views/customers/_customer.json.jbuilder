json.extract! customer, :id, :name, :phone, :fax, :street_address, :city, :state, :zip, :created_at, :updated_at
json.url customer_url(customer, format: :json)