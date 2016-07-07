require 'yaml'

module Cart
  module Config
    PROMOS_DEFAULT_PATH=
      File.expand_path('../../../../config/promos.yaml', __FILE__)
    PROMOS_DEFAULT_RATE=1.0

    # Current promo codes (as loaded from config/promos.yml)
    class Promos

      def initialize(path=PROMOS_DEFAULT_PATH)
        @promos = YAML.load_file(path)
      end

      def rate(code)
        return PROMOS_DEFAULT_RATE - @promos.fetch(code, 0)
      end

    end
  end
end
