require "keypic/version"
require "keypic/config"
require "keypic/proxy"

module Keypic

  def self.configuration
    @configuration ||= Config.new
  end

  def self.configure
    yield(configuration)
  end
end
