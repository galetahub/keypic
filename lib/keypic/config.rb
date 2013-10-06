module Keypic
  class Config
    attr_accessor :endpoint, :form_id, :format, :quantity

    def initialize
      @endpoint = "http://ws.keypic.com"
      @form_id = "secret_token_here"
      @format = :json
      @quantity = 1
    end
  end
end