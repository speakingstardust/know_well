require "administrate/base_dashboard"

class JigOrderDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    jig_order_line_items: Field::HasMany,
    jigs: Field::HasMany,
    customer: Field::BelongsTo,
    reports: Field::HasMany,
    id: Field::Number,
    date: Field::DateTime,
    notes: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    jig_order_line_item_id: Field::Number,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :jig_order_line_items,
    :jigs,
    :customer,
    :reports,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :jig_order_line_items,
    :jigs,
    :customer,
    :reports,
    :id,
    :date,
    :notes,
    :created_at,
    :updated_at,
    :jig_order_line_item_id,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :jig_order_line_items,
    :jigs,
    :customer,
    :reports,
    :date,
    :notes,
    :jig_order_line_item_id,
  ].freeze

  # Overwrite this method to customize how jig orders are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(jig_order)
  #   "JigOrder ##{jig_order.id}"
  # end
end
