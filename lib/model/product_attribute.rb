module M2api
  class ProductAttribute < Base
    Attributes = %i(
      attribute_id
      attribute_code
      frontend_input
      entity_type_id
      is_required
      default_frontend_label
      frontend_labels
      backend_type
      backend_model
      source_model
      default_value
      is_unique
      frontend_class
      is_visible
      scope
      options
      is_searchable
      is_visible_in_advanced_search
      is_comparable
      is_used_for_promo_rules
      is_visible_on_front
      used_in_product_listing
      validation_rules
      is_user_defined
      apply_to
      is_filterable
      is_filterable_in_search
      position
      is_used_in_grid
      is_visible_in_grid
      is_filterable_in_grid
      search_weight
      is_html_allowed_on_front
      used_for_sort_by
      is_global
      is_displayed_in_autocomplete
      is_display_rel_nofollow
      facet_min_coverage_rate
      facet_max_size
      facet_sort_order
      include_zero_false_values
    )

    Attributes.each do |attr|
      attr_accessor attr
    end

    class << self
      def unique_identifier
        :attribute_code
      end

      def base_path
        "products/attributes"
      end
    end
  end
end
