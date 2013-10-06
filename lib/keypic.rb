# encoding: utf-8
require "keypic/version"
require "keypic/config"
require "keypic/client"
require "keypic/proxy"

module Keypic

  def self.configuration
    @configuration ||= Keypic::Config.new
  end

  def self.configure
    block_given? ? yield(configuration) : configuration
  end
end
