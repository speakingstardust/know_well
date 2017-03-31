require 'pry'
class PagesController < ApplicationController
  def home
  end

  def jig_reporting
  end

  def work_orders
    @customers = Customer.all
  end

  def new_work_order
    work_order_type = params[:commit]
    @customer = Customer.find(params[:customer][:customer_id])
    if work_order_type == "Jig Work Order"
      redirect_to controller: 'jig_work_orders', action: 'new', customer: { customer_id: @customer.id }
    end
  end
end
