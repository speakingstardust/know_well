font_size 18
pdf.text "Jig Summary Report", align: :center


font_size 12
move_down 30

header = ['Jig Name', '# Cleaned', 'Cleaning Charge', 'Cleaning Subtotal', '# Repaired', 'Repair Charge', 'Repair Subtotal', 'Jig Subtotal']

jigs = Hash.new { |hash, key| hash[key] = Hash.new(&hash.default_proc) }

total_cleaned = 0
total_repaired = 0
total_cleaning_charge = 0.0
total_repair_charge = 0.0


@jig_orders.each do |jo|
	jo.jig_order_line_items.each do |li|
		if jigs.key?(li.jig.id)
			ov = jigs[li.jig.id][:cleaned]
			if li.cleaned.nil? 
				nv = ov
			else
				nv = li.cleaned + ov 
			end
			jigs[li.jig.id][:cleaned] = nv
		else
			jigs[li.jig.id][:cleaned] = li.cleaned
		end
	end
end

@jig_orders.each do |jo|
	jo.jig_order_line_items.each do |li|
		if jigs[li.jig.id][:repaired].nil?
			jigs[li.jig.id][:repaired] = li.repaired
		else
			ov = jigs[li.jig.id][:repaired].to_s.to_i
			if li.repaired.nil?
				nv = ov
			else 
				nv = li.repaired + ov
			end 
			jigs[li.jig.id][:repaired] = nv
		end
	end
end

@jig_orders.each do |jo|
	jo.jig_order_line_items.each do |li|
		jigs[li.jig.id][:name] = li.jig.name
	end
end

@jig_orders.each do |jo|
	jo.jig_order_line_items.each do |li|
		jigs[li.jig.id][:cleaning_charge] = li.jig.cleaning_charge
	end
end

@jig_orders.each do |jo|
	jo.jig_order_line_items.each do |li|
		jigs[li.jig.id][:repair_charge] = li.jig.repair_charge
	end
end

jig_table = []

jigs.each do |key, value|
	cleaning_subtotal = if value[:cleaned].to_s.to_f.nil? or value[:cleaning_charge].to_s.to_f.nil?
												0
											else
												total_cleaned = total_cleaned + value[:cleaned].to_s.to_f
												cleaning_charge = value[:cleaned].to_s.to_f * value[:cleaning_charge].to_s.to_f
												total_cleaning_charge = total_cleaning_charge + cleaning_charge
												cleaning_charge
											end

	repair_subtotal = if value[:repaired].to_s.to_f.nil? or value[:repair_charge].to_s.to_f.nil?
											0
										else
											total_repaired = total_repaired + value[:repaired].to_s.to_i
											repair_charge = value[:repaired].to_s.to_f * value[:repair_charge].to_s.to_f
											total_repair_charge = total_repair_charge + repair_charge
											repair_charge
										end

	jig_subtotal = cleaning_subtotal + repair_subtotal

	jig_table << [
	value[:name], 
	value[:cleaned],
	"$#{"%.2f" % value[:cleaning_charge]}",
	"$#{"%.2f" % cleaning_subtotal}",
	value[:repaired],
	"$#{"%.2f" % value[:repair_charge]}",
	"$#{"%.2f" % repair_subtotal}",
	"$#{"%.2f" % jig_subtotal}"
	]
end

pdf.table [header] + jig_table, header: true, width: pdf.bounds.width do
	row(0).style :font_style => :bold
end

move_down 30 

delivery_charge = @delivery_charge.to_f

total_charge = total_repair_charge + total_cleaning_charge + delivery_charge

pdf.text "Total Cleaned: #{"%.0f" % total_cleaned}"
pdf.text "Total Repaired: #{"%.0f" % total_repaired}"
pdf.text "Total Cleaning Charge: $#{"%.2f" % total_cleaning_charge}"
pdf.text "Total Repair Charge: $#{"%.2f" % total_repair_charge}"
pdf.text "Delivery Charge: $#{"%.2f" % delivery_charge}"
pdf.text "Total Charges: $#{"%.2f" % total_charge}"

 