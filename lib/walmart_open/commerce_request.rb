require "walmart_open/request"

module WalmartOpen
  class CommerceRequest < Request
    private

    def request_method
      :post
    end

    def build_url(client)
      url = "https://#{client.config.commerce_domain}"
      url << "/#{client.config.commerce_version}"
      url << "/qa" if client.config.debug
      url << "/#{path}"
      url << params_to_query_string(build_params(client))
    end

    def parse_response(response)
      OrderResults.new(response.parsed_response)
    end
  end
end
