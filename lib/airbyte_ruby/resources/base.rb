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
    end
  end
end