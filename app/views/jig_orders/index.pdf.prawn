font_size 18
pdf.text "Jig Summary Report", align: :center


font_size 12
move_down 30

header = ['Jig Name', '# Cleaned', 'Cleaning Charge', 'Cleaning Subtotal', '# Repaired', 'Repair Charge', 'Repair Subtotal', 'Jig Subtotal']

	
jigs = []

@jig_orders.each do |jig_order|
	jig_order.jig_order_line_items.each do |line_item|
		cleaning_subtotal = line_item.cleaned.nil? ? 0 : line_item.cleaned * line_item.jig.cleaning_charge
		repair_subtotal = line_item.repaired.nil? ? 0 : line_item.repaired * line_item.jig.repair_charge
		jig_subtotal = cleaning_subtotal + repair_subtotal
		jigs << [
			line_item.jig.name,
			line_item.cleaned,
			line_item.jig.cleaning_charge,
			cleaning_subtotal,
			line_item.repaired,
			line_item.jig.repair_charge,
			repair_subtotal,
			jig_subtotal
		]
	end
end

pdf.table [header] + jigs, header: true, width: pdf.bounds.width do
	row(0).style :font_style => :bold
end