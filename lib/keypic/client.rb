require "httpi"
require "multi_json"

module Keypic
  class Client
    attr_reader :last_response, :parsed_response

    @@methods = {
      :new_token => "RequestNewToken",
      :validate => "RequestValidation",
      :spam => "ReportSpam",
      :check_form => "checkFormID"
    }.freeze

    @@types = {
      :csv => 1,
      :json => 2,
      :php => 3,
      :xml => 4
    }.freeze

    def initialize(method_name, options = {})
      @method_name = method_name.to_sym

      @options = {
        "FormID": Config.form_id,
        "ResponseType": format,
        "RequestType": method
      }.merge(options)
    end

    def method
      @method ||= @@methods[@method_name]
    end

    def format
      @format ||= @@types[Config.format.to_sym]
    end

    def invoke(options = {})
      request.body = @options.merge(options)
      parse_response(HTTPI.post(request, :curb))
    end

    def request
      @request ||= HTTPI::Request.new(:url => Config.endpoint)
    end

    protected

      def parse_response(response)
        @last_response = response

        if response.error?
          @parsed_response = nil
        else
          @parsed_response = MultiJson.load(response.body)
        end

        @parsed_response
      end
  end
end