class JigSummaryPdf < Prawn::Document

	def initialize(jig_orders, view)
		super()
		@jig_orders = jig_orders
		@view = view
		text "This is a Jig Summary Report"
	end

end