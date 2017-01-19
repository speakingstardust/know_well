class ReportLineItem < ActiveRecord::Base
  belongs_to :report
  belongs_to :jig
end
