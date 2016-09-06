module ApplicationHelper

	def full_title(page_title='')
		base_title = "Know Well	"
		if page_title.empty?
			base_title
		else
			page_title + " | " + base_title
		end
	end

	def active_class(link_path)
		"active" if request.fullpath == link_path
	end

end
