# frozen_string_literal: true

module AirbyteRuby
  module Resources
    # Base class for Airbyte Resources
    # TODO: Move to module rather than class
    class Base
      include AirbyteRuby::Requests

      def to_json(*_args)
        raise NotImplementedError
      end

      def fetch_all
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
        url.gsub(":#{variable}", @id)
      end
    end
  end
end
