module Keypic
  class Proxy
    attr_reader :env

    def initialize(env)
      @env = env
    end

    def token
      @token ||= (fetch_token_from_session || fetch_token_form_server)
    end

    def valid?(options = {}, rank = 80)
      fetch_rank(options) >= rank.to_f
    end

    def spam?(options = {}, rank = 80)
      !valid?(options, rank)
    end

    def fetch_rank(options = {})
      params = normalize_message(options)
      params = { 'Token' => token }.merge(client_params).merge(params)

      body = Client.new(:validate).invoke(params)

      if body && body["status"] == 'response'
        body["spam"].to_f
      else
        0.0
      end
    end

    def client_params
      {
        'ServerName' => env['SERVER_NAME'],
        'ClientIP' => env['REMOTE_ADDR'],
        'ClientUserAgent' => env['HTTP_USER_AGENT'],
        'ClientAccept' => env['HTTP_ACCEPT'],
        'ClientAcceptEncoding' => env['HTTP_ACCEPT_ENCODING'],
        'ClientAcceptLanguage' => env['HTTP_ACCEPT_LANGUAGE'],
        'ClientAcceptCharset' => env['HTTP_ACCEPT_CHARSET'],
        'ClientHttpReferer' => env['HTTP_REFERER']
      }
    end

    def check!
      body = Client.new(:check_form).invoke

      if body && body["status"] == 'response'
        body["report"]
      end
    end

    def clear!
      session.delete("keypic.token")
      @token = nil
    end

    def session
      env["rack.session"] || {}
    end

    protected

      def fetch_token_from_session
        session["keypic.token"]
      end

      def fetch_token_form_server
        params = { 'Quantity' => Keypic.configuration.quantity }.merge(client_params)

        body = Client.new(:new_token).invoke(params)

        if body && body["status"] == 'new_token'
          body["Token"]
        end
      end

      def normalize_message(options)
        params = options.symbolize_keys

        {
          "ClientEmailAddress" => params[:email],
          "ClientUsername" => params[:name],
          "ClientMessage" => params[:message]
        }
      end

  end
end