font_size 18
pdf.text "Jig Summary Report", align: :center


font_size 12
move_down 30

header = ['Jig Name', '# Cleaned', 'Cleaning Charge', 'Cleaning Subtotal', '# Repaired', 'Repair Charge', 'Repair Subtotal', 'Jig Subtotal']

jigs = Hash.new { |hash, key| hash[key] = Hash.new(&hash.default_proc) }

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
			ov = jigs[li.jig.id][:repaired].to_s.to_f
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

puts jigs

jig_table = []

jigs.each do |key, value|
	cleaning_subtotal = if value[:cleaned].to_s.to_f.nil? or value[:cleaning_charge].to_s.to_f.nil?
												0
											else
												value[:cleaned].to_s.to_f * value[:cleaning_charge].to_s.to_f
											end

	repair_subtotal = if value[:repaired].to_s.to_f.nil? or value[:repair_charge].to_s.to_f.nil?
											0
										else
											value[:repaired].to_s.to_f * value[:repair_charge].to_s.to_f
										end

	jig_subtotal = cleaning_subtotal + repair_subtotal

	jig_table << [
	value[:name], 
	value[:cleaned],
	value[:cleaning_charge],
	cleaning_subtotal,
	value[:repaired],
	value[:repair_charge],
	repair_subtotal,
	jig_subtotal
	]
end

pdf.table [header] + jig_table, header: true, width: pdf.bounds.width do
	row(0).style :font_style => :bold
end