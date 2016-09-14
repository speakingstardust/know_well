class JigSummaryPdf < Prawn::Document

	def initialize(report, view)
		super()
		text "This is a Jig Summary Report"
	end

end