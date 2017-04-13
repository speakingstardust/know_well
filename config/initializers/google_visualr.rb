module GoogleVisualr
  class BaseChart
    def load_js(element_id)
      "\n  google.charts.load('visualization','1', {packages: ['#{package_name}'], callback: #{chart_function_name(element_id)}});"
    end
  end 

  module Interactive
    class GanttChart
      def class
        "Gantt"
      end
    end
  end
end
