require "administrate/base_dashboard"

class JigOrderLineItemDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    jig_order: Field::BelongsTo,
    jig: Field::BelongsTo,
    id: Field::Number,
    repaired: Field::Number,
    cleaned: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :jig_order,
    :jig,
    :id,
    :repaired,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :jig_order,
    :jig,
    :id,
    :repaired,
    :cleaned,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :jig_order,
    :jig,
    :repaired,
    :cleaned,
  ].freeze

  # Overwrite this method to customize how jig order line items are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(jig_order_line_item)
  #   "JigOrderLineItem ##{jig_order_line_item.id}"
  # end
end
