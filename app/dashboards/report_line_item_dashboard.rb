require "administrate/base_dashboard"

class ReportLineItemDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    report: Field::BelongsTo,
    jig: Field::BelongsTo,
    id: Field::Number,
    subtotal_cleaned: Field::Number,
    subtotal_repaired: Field::Number,
    cleaning_charge_subtotal: Field::Number.with_options(decimals: 2),
    repair_charge_subtotal: Field::Number.with_options(decimals: 2),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :report,
    :jig,
    :id,
    :subtotal_cleaned,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :report,
    :jig,
    :id,
    :subtotal_cleaned,
    :subtotal_repaired,
    :cleaning_charge_subtotal,
    :repair_charge_subtotal,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :report,
    :jig,
    :subtotal_cleaned,
    :subtotal_repaired,
    :cleaning_charge_subtotal,
    :repair_charge_subtotal,
  ].freeze

  # Overwrite this method to customize how report line items are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(report_line_item)
  #   "ReportLineItem ##{report_line_item.id}"
  # end
end
