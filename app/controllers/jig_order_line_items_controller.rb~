class JigOrderLineItemsController < ApplicationController
	before_action :authenticate_user!
	
  def index
  	@jig_order_line_items = JigOrderLineItem.all
  end



  private 

	  def jig_order_line_item_params
	  	params.require(:jig_order_line_item).permit(:repaired, :cleaned, :jig_id, :jig_order_id)
	  end
end
