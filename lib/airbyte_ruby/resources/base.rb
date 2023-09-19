module AirbyteRuby
  module Resources
    class Base
      include AirbyteRuby::Requests

      def to_json
        raise NotImplementedError
      end

      def get_all
        raise NotImplementedError
      end

      def new
        raise NotImplementedError
      end

      def fetch
        raise NotImplementedError
      end

      def remove
        raise NotImplementedError
      end

      private

      def replace_variable_in_url(url, variable)
        url.gsub(":#{variable}", @source_id)
      end
    end
  end
end