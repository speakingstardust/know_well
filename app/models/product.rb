class Product < ActiveRecord::Base
  belongs_to :manufacturer
  belongs_to :vendor
end
