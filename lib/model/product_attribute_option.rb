# Usage:
# M2api::ProductAttributeOption.for_attribute('color').all  # List all options for 'color' attribute
# M2api::ProductAttributeOption.for_attribute('color').create(label: 'Red', sort_order: 1)
# option.delete('color')  # Delete option from 'color' attribute

module M2api
  class ProductAttributeOption < Base
    Attributes = %i(
      label
      value
      sort_order
      is_default
      store_labels
    )

    Attributes.each do |attr|
      attr_accessor attr
    end

    attr_accessor :attribute_code

    def save
      raise ArgumentError, "attribute_code is required" unless self.attribute_code
      response = M2api::Base.call :post, "products/attributes/#{self.attribute_code}/options", self
      response
    end

    def delete attribute_code = nil
      attribute_code ||= self.attribute_code
      raise ArgumentError, "attribute_code is required" unless attribute_code
      raise ArgumentError, "value (option_id) is required" unless self.value
      M2api::Base.call :delete, "products/attributes/#{attribute_code}/options/#{self.value}", nil
    end

    def to_json is_put = nil
      Hash["option", self.to_h.reject { |k, _| k == "attribute_code" }].to_json
    end

    class << self
      # Returns a scoped query for a specific attribute
      # Example: M2api::ProductAttributeOption.for_attribute('color').all
      def for_attribute attribute_code
        AttributeOptionScope.new(attribute_code)
      end

      def unique_identifier
        :value
      end

      def base_path
        "products/attributes"
      end
    end
  end

  # Scoped class to handle attribute-specific option queries
  class AttributeOptionScope
    def initialize attribute_code
      @attribute_code = attribute_code
    end

    def all
      response = M2api::Base.call :get, "products/attributes/#{@attribute_code}/options", nil
      return [] if response.nil?
      response.map do |item|
        option = M2api::ProductAttributeOption.new(item)
        option.attribute_code = @attribute_code
        option
      end
    end

    def create attrs = {}
      option = M2api::ProductAttributeOption.new(attrs)
      option.attribute_code = @attribute_code
      option.save
    end

    def [] option_value
      all.find { |opt| opt.value.to_s == option_value.to_s }
    end
  end
end
