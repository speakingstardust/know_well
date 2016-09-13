class JigOrderLineItemsController < ApplicationController
	before_action :authenticate_user!
	
  def index
  	@jig_order_line_items = JigOrderLineItem.all
  end

  def print
  	@jig_order_line_items = JigOrderLineItem.all

  	send_data generate_jig_line_item_report(@jig_order_line_items), filename: 'Jig Report.pdf',
  																																	type: 'application/pdf',
  																																	disposition: 'attachment'

  end

  private 

	  def jig_order_line_item_params
	  	params.require(:jig_order_line_item).permit(:repaired, :cleaned, :jig_id, :jig_order_id)
	  end

	  def generate_jig_line_item_report(line_items)
	  	report = ThinReports::Report.new layout: "#{Rails.root}/app/reports/jig_test.tlf"

	  	line_items.each do |line_item|
	  		report.list.add_row do |row|
	  			row.values jig_name: line_item.jig.name
	  		end
	  	end

	  	report.generate
	  end

end
