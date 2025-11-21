# Usage:
# M2api::AttributeSet.all                    # List all attribute sets
# M2api::AttributeSet[4]                     # Get attribute set by ID
# M2api::AttributeSet.first                  # Get first attribute set
# attribute_set.attributes                   # Get attributes in this set

module M2api
  class AttributeSet < Base
    Attributes = %i(
      attribute_set_id
      attribute_set_name
      sort_order
      entity_type_id
    )

    Attributes.each do |attr|
      attr_accessor attr
    end

    # Get all attributes assigned to this attribute set
    def attributes
      raise ArgumentError, "attribute_set_id is required" unless self.attribute_set_id
      M2api::Base.call :get, "products/attribute-sets/#{self.attribute_set_id}/attributes", nil
    end

    # Get all attribute groups in this attribute set
    def groups
      raise ArgumentError, "attribute_set_id is required" unless self.attribute_set_id
      response = M2api::Base.call :get, "products/attribute-sets/groups/list", "searchCriteria[filter_groups][0][filters][0][field]=attribute_set_id&searchCriteria[filter_groups][0][filters][0][value]=#{self.attribute_set_id}"
      response.is_a?(Hash) && response[:items] ? response[:items] : response
    end

    class << self
      def unique_identifier
        :attribute_set_id
      end

      def base_path
        "products/attribute-sets"
      end

      def get_path
        "products/attribute-sets/sets/list"
      end

      def lower_case_name
        "attributeSet"
      end
    end
  end
end
