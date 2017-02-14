require "administrate/base_dashboard"

class JigDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    customer: Field::BelongsTo,
    jig_order_line_items: Field::HasMany,
    jig_orders: Field::HasMany,
    report_line_items: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    cleaning_charge: Field::Number.with_options(decimals: 2),
    repair_charge: Field::Number.with_options(decimals: 2),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    jig_order_line_item_id: Field::Number,
    jig_photo_file_name: Field::String,
    jig_photo_content_type: Field::String,
    jig_photo_file_size: Field::Number,
    jig_photo_updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :customer,
    :jig_order_line_items,
    :jig_orders,
    :report_line_items,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :customer,
    :jig_order_line_items,
    :jig_orders,
    :report_line_items,
    :id,
    :name,
    :cleaning_charge,
    :repair_charge,
    :created_at,
    :updated_at,
    :jig_order_line_item_id,
    :jig_photo_file_name,
    :jig_photo_content_type,
    :jig_photo_file_size,
    :jig_photo_updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :customer,
    :jig_order_line_items,
    :jig_orders,
    :report_line_items,
    :name,
    :cleaning_charge,
    :repair_charge,
    :jig_order_line_item_id,
    :jig_photo_file_name,
    :jig_photo_content_type,
    :jig_photo_file_size,
    :jig_photo_updated_at,
  ].freeze

  # Overwrite this method to customize how jigs are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(jig)
  #   "Jig ##{jig.id}"
  # end
end
