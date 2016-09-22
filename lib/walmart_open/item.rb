require "walmart_open/stock_string"

module WalmartOpen
  class Item
    API_ATTRIBUTES_MAPPING = {
      "itemId" => "id",
      "name" => "name",
      "salePrice" => "price",
      "upc" => "upc",
      "categoryNode" => "category_node",
      "shortDescription" => "short_description",
      "longDescription" => "long_description",
      "branchName" => "brand",
      "standardShipRate" => "shipping_rate",
      "size" => "size",
      "color" => "color",
      "modelNumber" => "model_number",
      "productUrl" => "url",
      "availableOnline" => "available_online",
      "largeImage" => "large_image",
      "thumbnailImage" => "thumbnail_image",
      "mediumImage" => "medium_image"
    }

    API_ATTRIBUTES_MAPPING.each_value do |attr_name|
      attr_reader attr_name
    end

    attr_reader :raw_attributes

    def self.get_all

    end

    def initialize(attrs)
      @raw_attributes = attrs
      extract_known_attributes
    end

    def variants
      raw_attributes["variants"].to_a
    end

    def stock
      if raw_attributes["stock"]
        @_stock ||= StockString.new(raw_attributes["stock"])
      end
    end

    private

    def extract_known_attributes
      API_ATTRIBUTES_MAPPING.each do |api_attr, attr|
        next unless raw_attributes.has_key?(api_attr)

        instance_variable_set("@#{attr}", raw_attributes[api_attr])
      end
    end
  end
end
