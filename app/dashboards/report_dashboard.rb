require "administrate/base_dashboard"

class ReportDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    report_line_items: Field::HasMany,
    jig_orders: Field::HasMany,
    customer: Field::BelongsTo,
    id: Field::Number,
    date_from: Field::DateTime,
    date_to: Field::DateTime,
    total_cleaned: Field::Number,
    total_repaired: Field::Number,
    cleaning_charge_total: Field::Number.with_options(decimals: 2),
    repair_charge_total: Field::Number.with_options(decimals: 2),
    charges_subtotal: Field::Number.with_options(decimals: 2),
    delivery_charge: Field::Number.with_options(decimals: 2),
    grand_total: Field::Number.with_options(decimals: 2),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :report_line_items,
    :jig_orders,
    :customer,
    :id,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :report_line_items,
    :jig_orders,
    :customer,
    :id,
    :date_from,
    :date_to,
    :total_cleaned,
    :total_repaired,
    :cleaning_charge_total,
    :repair_charge_total,
    :charges_subtotal,
    :delivery_charge,
    :grand_total,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :report_line_items,
    :jig_orders,
    :customer,
    :date_from,
    :date_to,
    :total_cleaned,
    :total_repaired,
    :cleaning_charge_total,
    :repair_charge_total,
    :charges_subtotal,
    :delivery_charge,
    :grand_total,
  ].freeze

  # Overwrite this method to customize how reports are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(report)
  #   "Report ##{report.id}"
  # end
end
