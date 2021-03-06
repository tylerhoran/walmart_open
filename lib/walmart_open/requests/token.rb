require "walmart_open/commerce_request"
require "walmart_open/auth_token"

module WalmartOpen
  module Requests
    class Token < CommerceRequest
      def initialize
        self.path = "oauth2/token"
      end

      private

      def request_options(client)
        {
          basic_auth: {
            username: client.config.commerce_api_key,
            password: client.config.commerce_api_secret
          },
          body: {
            grant_type: "client_credentials"
          }
        }
      end

      def parse_response(response)
        AuthToken.new(response.parsed_response, Time.parse(response.headers["date"]))
      end
    end
  end
end
