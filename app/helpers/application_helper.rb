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

  def us_states
  [
  ['Alabama', 'AL'],
  ['Alaska', 'AK'],
  ['Arizona', 'AZ'],
  ['Arkansas', 'AR'],
  ['California', 'CA'],
  ['Colorado', 'CO'],
  ['Connecticut', 'CT'],
  ['Delaware', 'DE'],
  ['District of Columbia', 'DC'],
  ['Florida', 'FL'],
  ['Georgia', 'GA'],
  ['Hawaii', 'HI'],
  ['Idaho', 'ID'],
  ['Illinois', 'IL'],
  ['Indiana', 'IN'],
  ['Iowa', 'IA'],
  ['Kansas', 'KS'],
  ['Kentucky', 'KY'],
  ['Louisiana', 'LA'],
  ['Maine', 'ME'],
  ['Maryland', 'MD'],
  ['Massachusetts', 'MA'],
  ['Michigan', 'MI'],
  ['Minnesota', 'MN'],
  ['Mississippi', 'MS'],
  ['Missouri', 'MO'],
  ['Montana', 'MT'],
  ['Nebraska', 'NE'],
  ['Nevada', 'NV'],
  ['New Hampshire', 'NH'],
  ['New Jersey', 'NJ'],
  ['New Mexico', 'NM'],
  ['New York', 'NY'],
  ['North Carolina', 'NC'],
  ['North Dakota', 'ND'],
  ['Ohio', 'OH'],
  ['Oklahoma', 'OK'],
  ['Oregon', 'OR'],
  ['Pennsylvania', 'PA'],
  ['Puerto Rico', 'PR'],
  ['Rhode Island', 'RI'],
  ['South Carolina', 'SC'],
  ['South Dakota', 'SD'],
  ['Tennessee', 'TN'],
  ['Texas', 'TX'],
  ['Utah', 'UT'],
  ['Vermont', 'VT'],
  ['Virginia', 'VA'],
  ['Washington', 'WA'],
  ['West Virginia', 'WV'],
  ['Wisconsin', 'WI'],
  ['Wyoming', 'WY']
  ]
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end
end
