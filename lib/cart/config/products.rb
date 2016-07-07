require 'yaml'

module Cart
  module Config
    PRODUCTS_DEFAULT_PATH=
      File.expand_path('../../../../config/products.yaml', __FILE__)

    # Current product list (as loaded from config/products.yaml)
    class Products

      def initialize(path=PRODUCTS_DEFAULT_PATH)
        @products = YAML.load_file(path)
      end

      def exists?(code)
        @products.has_key?(code)
      end

      def name(code)
        @products.has_key?(code) ? @products[code]['name'] : nil
      end

      def price(code)
        @products.has_key?(code) ? @products[code]['price'] : nil
      end

    end
  end
end
