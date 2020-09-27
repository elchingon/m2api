module M2api
  class Category < Base
    Attributes = %i(id parent_id name is_active position level product_count children_data)
    Attributes.each do |attr| attr_accessor attr end

    class << self
      def base_path
        "categories"
      end
    end
  end
end
